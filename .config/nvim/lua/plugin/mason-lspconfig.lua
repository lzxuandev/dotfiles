vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim"})
vim.pack.add({ "https://github.com/mason-org/mason.nvim"})

require("mason").setup {}

require("mason-lspconfig").setup {
    ensure_installed = {
        "clangd",
        "lua_ls",
        "rust_analyzer",
    },
}
