vim.o.background = 'dark'

require('vscode').setup({
    -- Alternatively set style in setup
    style = 'dark',

    -- Enable transparent background
    transparent = true,

    -- Enable italic comment
    italic_comments = true,

    -- Enable italic inlay type hints
    italic_inlayhints = true,

    -- Underline `@markup.link.*` variants
    underline_links = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Apply theme colors to terminal
    terminal_colors = true,

    group_overrides = {
        SpecialChar = { fg = "#dcdcaa" },
    }
})

vim.cmd.colorscheme "vscode"
