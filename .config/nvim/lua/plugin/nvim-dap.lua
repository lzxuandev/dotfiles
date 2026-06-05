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
