vim.pack.add({"https://github.com/neovim/nvim-lspconfig"})


vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'cxx', 'h', 'hpp', 'hxx' },
})


vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
})

vim.lsp.enable({ "clangd", "lua_ls", "rust_analyzer", })


vim.keymap.set( "n", "D", vim.diagnostic.open_float)
vim.keymap.set( "n", "<leader>ft", function() vim.lsp.buf.format() end, { desc = "Format buffer with LSP" })

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.api.nvim_set_hl(0, "NormalFloat",  { bg = "#222222" })
    end,
})
