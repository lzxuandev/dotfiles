local treesitter = require('nvim-treesitter')
local languages = { 'c', 'cpp', 'lua' }

vim.opt.runtimepath:prepend(vim.fn.stdpath('data') .. '/site/pack/core/opt/nvim-treesitter/runtime')

treesitter.setup {
    install_dir = vim.fn.stdpath('data') .. '/site',
    highlight = { enable = true },
    indent = { enable = true },
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = languages,
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
