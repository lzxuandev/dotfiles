vim.pack.add({ "https://github.com/saghen/blink.cmp" })
vim.pack.add({ "https://github.com/saghen/blink.lib" })
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })

vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = "#222222" })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = "#222222" })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { bg = "#222222" })
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#222222" })

require('blink.cmp').setup({
    keymap = { preset = 'super-tab' },

    completion = {
        menu = {
            auto_show = true,
            auto_show_delay_ms = 0,
            max_height = 5,
            scrollbar = false,
        },
        documentation = {
            auto_show = false
        },
        ghost_text = {
            enabled = false,
            show_with_menu = true
        }
    },
    signature = {
        enabled = false,
        trigger = {
            enabled = true
        },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = {
        implementation = "lua"
    }
})
