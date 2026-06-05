-- Global
vim.g.mapleader = " "

-- Insert
vim.keymap.set("i", "jk", "<Esc>")

-- Visual
vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })
vim.keymap.set("v", "H", "^")
vim.keymap.set("v", "L", "$")

-- Normal
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

vim.keymap.set("n", "<C-L>", ":bnext<CR>")
vim.keymap.set("n", "<C-H>", ":bprevious<CR>")

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

vim.keymap.set("n", "<leader>u", function() vim.cmd.packadd("nvim.undotree") require("undotree").open() end, { desc = "Toggle Builtin Undotree" })

-- without losing yank
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })

-- Backspace smart delete
local function smart_backspace() local line = vim.api.nvim_get_current_line() local col = vim.api.nvim_win_get_cursor(0)[2] local before_cursor = line:sub(1, col) if before_cursor:match("%s+$") then vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>", true, false, true), "n", true) else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>", true, false, true), "n", true) end end
vim.keymap.set("i", "<C-BS>", smart_backspace, { noremap = true })
