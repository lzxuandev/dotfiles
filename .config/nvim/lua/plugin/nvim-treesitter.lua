vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"})

require('nvim-treesitter').setup {
    install_dir = vim.fn.stdpath('data') .. '/site',
    highlight = { enable = true },
    indent = { enable = true },
}

require('nvim-treesitter').install { 'c', 'lua', 'rust', 'markdown', 'markdown_inline' }

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c' , 'cpp', 'lua', 'rs', 'markdown', 'markdown_inline'},
    callback = function() vim.treesitter.start() end,
})
