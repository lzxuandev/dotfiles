require('nvim-treesitter').setup {
    ensured_installed = { 'c', 'cpp', 'lua' },
    install_dir = vim.fn.stdpath('data') .. '/site',
    highlight = { enable = true },
    indent = { enable = true },
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp', 'lua' },
    callback = function()
        vim.treesitter.start()
    end,
})
