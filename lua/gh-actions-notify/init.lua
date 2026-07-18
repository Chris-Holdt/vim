local M = {}

if vim.fn.has("nvim-0.10") == 0 then
  vim.notify("gh-actions-notify.nvim requires Neovim >= 0.10", vim.log.levels.ERROR)
  return M
end

-- ── Constants ─────────────────────────────────────────────────────────────────

local GH_JSON_FIELDS   = "databaseId,status,conclusion,name,headBranch,workflowName,createdAt,updatedAt"
local FLOAT_TITLE      = "  GitHub Actions "
local SPINNER_FRAMES   = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local SPINNER_INTERVAL = 80    -- ms per animation frame
local PEEK_TIMEOUT     = 5000  -- ms; intentionally shorter than notify_timeout

-- ── Configuration ─────────────────────────────────────────────────────────────

local default_config = {
  poll_interval  = 30000, -- ms between background polls
  limit          = 15,    -- number of recent runs to fetch
  notify_timeout = 30000, -- ms completion notifications stay visible
  auto_start     = true,  -- start polling automatically on setup()
  float_width    = 96,    -- float column width (capped to terminal width)
}

-- ── Icons & highlights ────────────────────────────────────────────────────────

local STATUS_ICON = {
  in_progress = "󰔟",
  queued      = "󰔟",
  waiting     = "…",
}

local CONCLUSION_ICON = {
  success         = "✓",
  failure         = "✗",
  cancelled       = "⊘",
  timed_out       = "⏱",
  action_required = "!",
  skipped         = "↷",
}

local CONCLUSION_HL = {
  success         = "DiagnosticOk",
  failure         = "DiagnosticError",
  cancelled       = "DiagnosticWarn",
  timed_out       = "DiagnosticError",
  action_required = "DiagnosticWarn",
  skipped         = "Comment",
}

local CONCLUSION_LEVEL = {
  success         = vim.log.levels.INFO,
  failure         = vim.log.levels.ERROR,
  cancelled       = vim.log.levels.WARN,
  timed_out       = vim.log.levels.ERROR,
  action_required = vim.log.levels.WARN,
}

local RESULT_LABEL = {
  success         = "Success",
  failure         = "Failure",
  cancelled       = "Cancelled",
  timed_out       = "Timed Out",
  action_required = "Action Required",
  skipped         = "Skipped",
  in_progress     = "In Progress",
  queued          = "Queued",
  waiting         = "Waiting",
  completed       = "Completed",
}

-- ── State ─────────────────────────────────────────────────────────────────────

local state = {
  timer         = nil,
  known_runs    = {},     -- [id] -> status string, used to detect transitions
  last_runs     = {},     -- most recent API response, drives the float view
  float_win     = nil,
  float_buf     = nil,
  notif_ids     = {},     -- snacks notification IDs tracked for M.clear_notifications()
  notif_queue   = {},     -- completion alerts deferred until the user leaves insert mode
  refreshing    = false,
  spinner_timer = nil,
  spinner_frame = 1,
  config        = {},
  setup_done    = false,
}

local NS = vim.api.nvim_create_namespace("gh_actions_notify")

-- ── Helpers ───────────────────────────────────────────────────────────────────

local function run_icon(run)
  if run.status == "completed" then
    return CONCLUSION_ICON[run.conclusion] or "?"
  end
  return STATUS_ICON[run.status] or "…"
end

local function run_hl(run)
  if run.status == "completed" then
    return CONCLUSION_HL[run.conclusion] or "Normal"
  elseif run.status == "in_progress" then
    return "DiagnosticInfo"
  end
  return "Comment"
end

local function fmt_date(ts)
  if not ts then return "" end
  return ts:sub(1, 16):gsub("T", " ")
end

-- Parse an ISO 8601 UTC timestamp into a Unix epoch integer via os.time().
-- Both timestamps in a duration calculation share the same local-offset error,
-- so their *difference* is always correct regardless of the system timezone.
local function parse_iso(ts)
  local y, mo, d, h, mi, s = ts:match("(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)")
  if not y then return nil end
  return os.time({
    year  = tonumber(y),  month = tonumber(mo), day = tonumber(d),
    hour  = tonumber(h),  min   = tonumber(mi), sec = tonumber(s),
  })
end

local function fmt_duration(created_at, updated_at)
  if not created_at or not updated_at then return "" end
  local t1, t2 = parse_iso(created_at), parse_iso(updated_at)
  if not t1 or not t2 then return "" end
  local diff = math.max(0, t2 - t1)
  if diff < 60 then
    return diff .. "s"
  elseif diff < 3600 then
    local mins, secs = math.floor(diff / 60), diff % 60
    return secs > 0 and (mins .. "m " .. secs .. "s") or (mins .. "m")
  else
    local hours, mins = math.floor(diff / 3600), math.floor((diff % 3600) / 60)
    return mins > 0 and (hours .. "h " .. mins .. "m") or (hours .. "h")
  end
end

local function fmt_result(run)
  local raw = run.status == "completed"
              and (run.conclusion or "completed")
              or  run.status
  return RESULT_LABEL[raw] or raw
end

local function get_repo_root()
  local result = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")
  if vim.v.shell_error ~= 0 then return nil end
  return result[1]
end

local function get_float_w()
  return math.min(state.config.float_width, vim.o.columns - 4)
end

-- ── Notifications ─────────────────────────────────────────────────────────────

-- Deliver a notification via snacks.nvim when available, else vim.notify.
-- Tracks snacks IDs so M.clear_notifications() can dismiss them later.
local function notify(msg, level, opts)
  local ok, Snacks = pcall(require, "snacks")
  if ok and Snacks.notify then
    local notif = Snacks.notify(msg, vim.tbl_extend("force", { level = level }, opts or {}))
    if type(notif) == "table" and notif.id then
      table.insert(state.notif_ids, notif.id)
    end
  else
    vim.notify(msg, level, opts)
  end
end

-- Queue a notification while the user is typing; flush when they leave insert mode.
-- Prevents workflow completion alerts from interrupting mid-sentence.
local function notify_deferred(msg, level, opts)
  local mode = vim.fn.mode()
  if mode:sub(1, 1) == "i" or mode:sub(1, 1) == "R" then
    local is_first = #state.notif_queue == 0
    table.insert(state.notif_queue, { msg = msg, level = level, opts = opts })
    if is_first then
      vim.api.nvim_create_autocmd("InsertLeave", {
        once     = true,
        callback = function()
          for _, n in ipairs(state.notif_queue) do
            notify(n.msg, n.level, n.opts)
          end
          state.notif_queue = {}
        end,
      })
    end
  else
    notify(msg, level, opts)
  end
end

-- ── Float window ──────────────────────────────────────────────────────────────

local function render_float()
  if not state.float_buf or not vim.api.nvim_buf_is_valid(state.float_buf) then return end

  local float_w = get_float_w()
  vim.api.nvim_set_option_value("modifiable", true, { buf = state.float_buf })
  vim.api.nvim_buf_clear_namespace(state.float_buf, NS, 0, -1)

  local lines = {}
  local hls   = {}

  local function hl(lnum, cs, ce, group)
    table.insert(hls, { lnum, cs, ce, group })
  end

  table.insert(lines, string.format(
    "  %-2s  %-24s  %-16s  %-14s  %-10s  %s",
    "", "Workflow", "Branch", "Started (UTC)", "Duration", "Result"
  ))
  table.insert(lines, string.rep("─", float_w))
  hl(0, 0, -1, "Title")
  hl(1, 0, -1, "Comment")

  if #state.last_runs == 0 then
    table.insert(lines, "  No recent runs found.")
    hl(2, 0, -1, "Comment")
  else
    for i, run in ipairs(state.last_runs) do
      local lnum     = i + 1 -- 0-based: header=0, sep=1, first run=2
      local icon     = run_icon(run)
      local wf       = (run.workflowName or run.name or "Unknown"):sub(1, 24)
      local branch   = (run.headBranch or ""):sub(1, 16)
      local date     = fmt_date(run.createdAt)
      local duration = fmt_duration(run.createdAt, run.updatedAt)
      local result   = fmt_result(run)

      table.insert(lines, string.format(
        "  %-2s  %-24s  %-16s  %-14s  %-10s  %s",
        icon, wf, branch, date, duration, result
      ))
      hl(lnum, 2, 4, run_hl(run))
    end
  end

  table.insert(lines, string.rep("─", float_w))
  table.insert(lines, "  [r] refresh    [q / <Esc>] close")
  local last = #lines - 1
  hl(last - 1, 0, -1, "Comment")
  hl(last,     0, -1, "Comment")

  vim.api.nvim_buf_set_lines(state.float_buf, 0, -1, false, lines)

  for _, h in ipairs(hls) do
    vim.api.nvim_buf_add_highlight(state.float_buf, NS, h[4], h[1], h[2], h[3])
  end

  vim.api.nvim_set_option_value("modifiable", false, { buf = state.float_buf })
end

local function update_float_title()
  if not state.float_win or not vim.api.nvim_win_is_valid(state.float_win) then return end
  local title = state.refreshing
    and (FLOAT_TITLE .. " " .. SPINNER_FRAMES[state.spinner_frame])
    or  FLOAT_TITLE
  vim.api.nvim_win_set_config(state.float_win, { title = title, title_pos = "center" })
end

local function stop_spinner()
  if state.spinner_timer then
    state.spinner_timer:stop()
    state.spinner_timer:close()
    state.spinner_timer = nil
  end
  state.spinner_frame = 1
  update_float_title()
end

local function start_spinner()
  if state.spinner_timer then return end
  if not state.float_win or not vim.api.nvim_win_is_valid(state.float_win) then return end
  state.spinner_frame = 1
  state.spinner_timer = vim.uv.new_timer()
  state.spinner_timer:start(0, SPINNER_INTERVAL, vim.schedule_wrap(function()
    if not state.refreshing
      or not state.float_win
      or not vim.api.nvim_win_is_valid(state.float_win) then
      stop_spinner()
      return
    end
    state.spinner_frame = (state.spinner_frame % #SPINNER_FRAMES) + 1
    update_float_title()
  end))
end

local function close_float()
  stop_spinner()
  if state.float_win and vim.api.nvim_win_is_valid(state.float_win) then
    vim.api.nvim_win_close(state.float_win, true)
  end
  state.float_win = nil
  state.float_buf = nil
end

-- ── Polling ───────────────────────────────────────────────────────────────────

local poll -- forward declaration

local function handle_data(data)
  local json = table.concat(data, "")
  if json == "" then return end

  local ok, runs = pcall(vim.json.decode, json)
  if not ok or type(runs) ~= "table" then return end

  state.last_runs  = runs
  state.refreshing = false
  stop_spinner()

  for _, run in ipairs(runs) do
    local id   = tostring(run.databaseId)
    local prev = state.known_runs[id]
    local curr = run.status

    if prev and prev ~= "completed" and curr == "completed" then
      local conclusion = run.conclusion or "unknown"
      local icon       = CONCLUSION_ICON[conclusion] or "?"
      local level      = CONCLUSION_LEVEL[conclusion] or vim.log.levels.INFO
      notify_deferred(
        string.format("%s %s\n%s → %s",
          icon,
          run.workflowName or run.name or "Workflow",
          run.headBranch or "unknown",
          RESULT_LABEL[conclusion] or conclusion
        ),
        level,
        { title = "GitHub Actions", timeout = state.config.notify_timeout }
      )
    end

    state.known_runs[id] = curr
  end

  if state.float_win and vim.api.nvim_win_is_valid(state.float_win) then
    render_float()
  end
end

-- Shared async runner used by both the background poller and on-demand fetches.
-- Handles stderr surfacing, on_exit cleanup, and jobstart failure detection.
local function fetch_runs(limit, on_data)
  local cwd = get_repo_root()
  if not cwd then return end

  local job_id = vim.fn.jobstart(
    {
      "gh", "run", "list",
      "--json", GH_JSON_FIELDS,
      "--limit", tostring(limit),
    },
    {
      cwd             = cwd,
      stdout_buffered = true,
      on_stdout       = function(_, data) on_data(data) end,
      on_stderr       = function(_, data)
        local msg = table.concat(data, ""):gsub("%s+$", "")
        if msg ~= "" then
          vim.schedule(function()
            notify("gh: " .. msg, vim.log.levels.WARN, { title = "GitHub Actions" })
          end)
        end
      end,
      on_exit         = function(_, code)
        if code ~= 0 then
          state.refreshing = false
          vim.schedule(stop_spinner)
        end
      end,
    }
  )

  if job_id <= 0 then
    state.refreshing = false
    stop_spinner()
    notify(
      "Could not start `gh` process — is the gh CLI installed and on your PATH?",
      vim.log.levels.ERROR,
      { title = "GitHub Actions" }
    )
  end
end

poll = function()
  state.refreshing = true
  start_spinner()
  fetch_runs(state.config.limit, handle_data)
end

-- ── Public API ────────────────────────────────────────────────────────────────

function M.toggle_float()
  if state.float_win and vim.api.nvim_win_is_valid(state.float_win) then
    close_float()
    return
  end

  local float_w = get_float_w()
  local float_h = math.min(math.max(#state.last_runs + 4, 6), 30)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

  local ok, win = pcall(vim.api.nvim_open_win, buf, true, {
    relative  = "editor",
    width     = float_w,
    height    = float_h,
    row       = math.floor((vim.o.lines   - float_h) / 2),
    col       = math.floor((vim.o.columns - float_w) / 2),
    style     = "minimal",
    border    = "rounded",
    title     = FLOAT_TITLE,
    title_pos = "center",
  })

  if not ok then
    vim.api.nvim_buf_delete(buf, { force = true })
    return
  end

  state.float_buf = buf
  state.float_win = win

  -- Render with cached data immediately, then poll so the view updates
  -- automatically once the API responds.
  render_float()
  poll()

  local map_opts = { buffer = buf, nowait = true, silent = true }
  vim.keymap.set("n", "q",     close_float, map_opts)
  vim.keymap.set("n", "<Esc>", close_float, map_opts)
  vim.keymap.set("n", "r",     poll,        map_opts)

  vim.api.nvim_create_autocmd("WinLeave", {
    buffer   = buf,
    once     = true,
    callback = close_float,
  })
end

-- Dismiss all gh-actions-notify notifications still on screen.
function M.clear_notifications()
  local ok, Snacks = pcall(require, "snacks")
  if ok and Snacks.notifier then
    for _, id in ipairs(state.notif_ids) do
      pcall(function() Snacks.notifier.hide(id) end)
    end
  end
  state.notif_ids = {}
end

-- Show a brief (PEEK_TIMEOUT ms) notification with the latest run's status.
-- Uses cached data when available; falls back to a fresh fetch if the cache
-- is cold (e.g. called before the first background poll has completed).
function M.peek_latest()
  local function show(run)
    notify(
      string.format("%s %s\n%s • %s",
        run_icon(run),
        run.workflowName or run.name or "Workflow",
        run.headBranch or "unknown",
        fmt_result(run)
      ),
      vim.log.levels.INFO,
      { title = "GitHub Actions", timeout = PEEK_TIMEOUT }
    )
  end

  if #state.last_runs > 0 then
    show(state.last_runs[1])
    return
  end

  local cwd = get_repo_root()
  if not cwd then
    notify("Not in a git repository", vim.log.levels.WARN,
      { title = "GitHub Actions", timeout = PEEK_TIMEOUT })
    return
  end

  fetch_runs(1, function(data)
    local json = table.concat(data, "")
    if json == "" then return end
    local ok, runs = pcall(vim.json.decode, json)
    if not ok or type(runs) ~= "table" or #runs == 0 then
      notify("No recent runs found", vim.log.levels.INFO,
        { title = "GitHub Actions", timeout = PEEK_TIMEOUT })
      return
    end
    show(runs[1])
  end)
end

function M.start()
  if state.timer then return end
  poll() -- seed known_runs on startup; no notifications fired on this first pass
  state.timer = vim.uv.new_timer()
  state.timer:start(
    state.config.poll_interval,
    state.config.poll_interval,
    vim.schedule_wrap(poll)
  )
end

function M.stop()
  if not state.timer then return end
  state.timer:stop()
  state.timer:close()
  state.timer      = nil
  state.notif_queue = {} -- discard any deferred notifications
end

function M.toggle_poller()
  if state.timer then
    M.stop()
    notify("Notifications stopped", vim.log.levels.INFO, { title = "GitHub Actions" })
  else
    M.start()
    notify("Notifications started", vim.log.levels.INFO, { title = "GitHub Actions" })
  end
end

function M.setup(opts)
  if state.setup_done then return end
  state.setup_done = true

  state.config = vim.tbl_deep_extend("force", default_config, opts or {})

  vim.api.nvim_create_user_command("GhActionsFloat",  M.toggle_float,        { desc = "Toggle GitHub Actions run list float" })
  vim.api.nvim_create_user_command("GhActionsNotify", M.toggle_poller,       { desc = "Toggle GitHub Actions background notifications" })
  vim.api.nvim_create_user_command("GhActionsClear",  M.clear_notifications, { desc = "Clear GitHub Actions notifications" })
  vim.api.nvim_create_user_command("GhActionsPeek",   M.peek_latest,         { desc = "Show latest GitHub Actions run status" })

  if state.config.auto_start then
    M.start()
  end
end

return M
