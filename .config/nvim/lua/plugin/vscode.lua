vim.pack.add({"https://github.com/mofiqul/vscode.nvim"})
vim.o.background = 'dark'

require('vscode').setup({
    style = 'dark',
    transparent = true,
    italic_comments = true,
    italic_inlayhints = true,
    underline_links = true,
    disable_nvimtree_bg = true,
    terminal_colors = true,

    group_overrides = { SpecialChar = { fg = "#dcdcaa" },}
})

vim.cmd.colorscheme "vscode"
