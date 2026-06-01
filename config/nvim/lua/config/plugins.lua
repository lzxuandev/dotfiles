vim.pack.add({
    "https://github.com/mofiqul/vscode.nvim",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/nvim-treesitter/nvim-treesitter",

    "https://github.com/saghen/blink.cmp",
    "https://github.com/saghen/blink.lib",
    "https://github.com/rafamadriz/friendly-snippets",

    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/brenoprata10/nvim-highlight-colors",
    "https://github.com/cappyzawa/trim.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
})

require("plugin.vscode")
require("plugin.nvim-tree")
require("plugin.nvim-lspconfig")
require("plugin.nvim-treesitter")

require("plugin.blink-cmp")

require("plugin.nvim-autopairs")
require("plugin.nvim-highlight-colors")
require("plugin.trim")
require("plugin.lualine")
require("plugin.rainbow-delimiters")
