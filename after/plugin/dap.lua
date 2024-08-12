local dap = require "dap"
local ui = require "dapui"
local wk = require "which-key"
local dapgo = require "dap-go"

-- Run setups
dapgo.setup()
ui.setup()

-- Key bindings
wk.add({
  -- DAP
  { "<leader>g",  group = "debug",                name = "Debug" },
  { "<leader>gb", dap.toggle_breakpoint,          group = "debug", name = "Toggle breakpoint" },
  { "<leader>gt", dap.run_to_cursor,              group = "debug", name = "Run to cursor" },
  { "<leader>gc", dap.continue,                   group = "debug", name = "Continue" },
  { "<leader>gd", dap.disconnect,                 group = "debug", name = "Disconnect" },
  { "<leader>gr", dap.restart,                    group = "debug", name = "Restart" },
  { "<F6>",       dap.step_into,                  group = "debug", name = "Step into" },
  { "<F7>",       dap.step_over,                  group = "debug", name = "Step over" },
  { "<F8>",       dap.step_out,                   group = "debug", name = "Step out" },
  { "<F9>",       dap.step_back,                  group = "debug", name = "Step back" },
  { "<F10>",      dap.toggle_ui,                  group = "debug", name = "Toggle UI" },
  -- UI
  { "<leader>g?", ui.eval(nil, { enter = true }), group = "debug", name = "Eval under cursor" }
})

-- Auto open/close UI
dap.listeners.before.attach.dapui_config = function()
  ui.open()
end

dap.listeners.before.launch.dapui_config = function()
  ui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end

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
