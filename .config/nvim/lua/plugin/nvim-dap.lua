vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/thehamsta/nvim-dap-virtual-text"
})

local dap = require('dap')

dap.adapters.gdb = {
  type = 'executable',
  command = 'gdb',
  args = { '--interpreter=dap', '--eval-command', 'set print pretty on' }
}

dap.configurations.c = {
  {
    name = 'Launch (GDB)',
    type = 'gdb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = false,
    setupCommands = {
      {
        text = '-dir ' .. vim.fn.getcwd(),
        description = 'add source directory',
      }
    },
  },
}

require("nvim-dap-virtual-text").setup {
    enabled = true,                        -- enable this plugin (the default)
    enable_commands = true,                -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = false,         -- show virtual text at every definition while debugging
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
    clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
    virt_text_pos = "eol",
}

local dapui = require("dapui")

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

dapui.setup({
  layouts = {
    {
      position = "right",
      size = 0.4,
      elements = {
        { id = "scopes", size = 1.00},
      },
    },
    {
      position = "bottom",
      size = 0.2,
      elements = {
        { id = "repl", size = 1.0 },
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
vim.keymap.set('n', '<leader>dB', function() local input = vim.fn.input('Condition for breakpoint: ') dap.set_breakpoint(input) end, { desc = 'DAP: Conditional Breakpoint' })
vim.keymap.set('n', '<leader>dD', dap.clear_breakpoints, { desc = 'DAP: Clear Breakpoints' })
