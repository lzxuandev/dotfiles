vim.pack.add({"https://github.com/mbbill/undotree"})
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.g.undotree_WindowLayout = 3
vim.g.undotree_SplitWidth = 30
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_DiffAutoOpen = 1
vim.g.undotree_DiffCommand = "diff"
vim.g.undotree_HighlightChangedText = 1
vim.g.undotree_HighlightChangedWithSign = 1  
vim.g.undotree_ShortIndicators = 0
vim.g.undotree_CursorLine = 0
vim.g.undotree_StatusLine = 0
