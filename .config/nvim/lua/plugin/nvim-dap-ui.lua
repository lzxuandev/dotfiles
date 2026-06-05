local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

dapui.setup({
  layouts = {
    {
      position = "right",
      size = 0.4,
      elements = {
        { id = "scopes", size = 0.70},
        { id = "breakpoints", size = 0.10 },
        { id = "stacks", size = 0.20 },
      },
    },
    {
      position = "bottom",
      size = 0.2,
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
    },
  },
})

vim.fn.sign_define('DapBreakpoint', {
    text = '●',
    texthl = 'DapBreakpoint',
    linehl = '',
    numhl = 'DapBreakpoint'
})
vim.fn.sign_define('DapBreakpointCondition', {
    text = '',
    texthl = 'DapBreakpoint',
    linehl = '',
    numhl = 'DapBreakpoint'
})
vim.fn.sign_define('DapStopped', {
    text = '',
    texthl = 'DapStopped',
    linehl = 'DapStopped',
    numhl = 'DapStopped'
})

vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'DAP: Toggle UI' })
vim.keymap.set('n', '<leader>ds', dap.continue, { desc = 'DAP: Start/Continue' })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'DAP: Step into' })
vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'DAP: Step over' })
vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'DAP: Step out' })
vim.keymap.set('n', '<leader>dq', dap.close, { desc = 'DAP: Close session' })
vim.keymap.set('n', '<leader>dQ', dap.terminate, { desc = 'DAP: Terminate session' })
vim.keymap.set('n', '<leader>dr', dap.restart, { desc = 'DAP: Restart' })

vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'DAP: Run to Cursor' })
vim.keymap.set('n', '<leader>dR', dap.repl.toggle, { desc = 'DAP: Toggle REPL' })
vim.keymap.set('n', '<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = 'DAP: Hover' })

vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dB', function()
    local input = vim.fn.input('Condition for breakpoint: ')
    dap.set_breakpoint(input)
end, { desc = 'DAP: Conditional Breakpoint' })
vim.keymap.set('n', '<leader>dD', dap.clear_breakpoints, { desc = 'DAP: Clear Breakpoints' })
