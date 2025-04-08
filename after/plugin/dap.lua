local dap = require "dap"
local ui = require "dapui"
local wk = require "which-key"
local dapgo = require "dap-go"
local hard = require "hardtime"
local tele = require "telescope"
local dapvt = require "nvim-dap-virtual-text"

-- Run setups
dapgo.setup({
  dap_configurations = {
    {
      type = "go",
      name = "Attach remote",
      request = "attach",
      mode = "remote",
      port = "38697",
      host = "localhost",
    },
  },
})

-- UI Layout
local function dapUILayout()
  return {
    layouts = {
      {
        elements = {
          {
            id = "breakpoints",
            size = 0.35,
          },
          {
            id = "stacks",
            size = 0.35,
          },
          {
            id = "repl",
            size = 0.15,
          },
          {
            id = "console",
            size = 0.15,
          },
        },
        position = "left",
        size = 0.10,
      },
      {
        elements = {
          {
            id = "scopes",
            size = 0.9,
          }
        },
        position = "bottom",
        size = 20,
      }
    }
  }
end


ui.setup(dapUILayout())
tele.load_extension("dap")
dapvt.setup()

local function dapBreakpointCondition()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end

local function dapLogPointMessage()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end

local function dapRunRemoteGo()
  dap.run({
    type = "go",
    name = "Attach remote",
    request = "attach",
    mode = "remote",
    port = "38697",
    host = "localhost",
  })
end

-- Key bindings
wk.add({
  -- DAP
  { "<leader>d",  group = "Debug" },
  { "<leader>db", dap.toggle_breakpoint,                desc = "Toggle breakpoint" },
  { "<leader>dB", dapBreakpointCondition,               desc = "Set conditional breakpoint" },
  { "<leader>dm", dapLogPointMessage,                   desc = "Set Log point message breakpoint" },
  -- { "<leader>dt", dap.run_to_cursor,                    desc = "Run to cursor" },
  { "<leader>dc", dap.continue,                         desc = "Continue" },
  { "<leader>dt", dapgo.debug_test,                     desc = "Go Debug Test" },
  { "<leader>da", dapRunRemoteGo,                       desc = "Attach to remote" },
  { "<leader>dd", dap.disconnect,                       desc = "Disconnect" },
  { "<leader>dr", dap.restart,                          desc = "Restart" },
  { "<leader>du", dap.toggle_ui,                        desc = "Toggle UI" },
  { "<leader>dl", tele.extensions.dap.list_breakpoints, desc = "List Breakpoints" },
  { "<F5>",       dap.continue,                         group = "Debug",                          desc = "Continue" },
  { "<F6>",       dap.step_into,                        group = "Debug",                          desc = "Step into" },
  { "<F7>",       dap.step_over,                        group = "Debug",                          desc = "Step over" },
  { "<F8>",       dap.step_out,                         group = "Debug",                          desc = "Step out" },
  { "<F9>",       dap.step_back,                        group = "Debug",                          desc = "Step back" },
  { "<F10>",      dap.toggle_ui,                        group = "Debug",                          desc = "Toggle UI" },
  -- UI
  { "<leader>d?", ui.eval(nil, { enter = true }),       group = "Debug",                          desc = "Eval under cursor" }
})

-- Auto open/close UI
dap.listeners.before.attach.dapui_config = function()
  hard.disable()
  ui.open()
end

dap.listeners.before.launch.dapui_config = function()
  hard.disable()
  ui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
  hard.enable()
  ui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
  hard.enable()
  ui.close()
end

-- Node.js/JS Debugging
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/home/chris/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
  },
  {
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require "dap.utils".pick_process,
  }
}
