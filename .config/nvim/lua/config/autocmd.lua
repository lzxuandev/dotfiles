vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.api.nvim_set_hl(0, "StatusLine",   { bg = "NONE" })
        vim.api.nvim_set_hl(0, "Normal",       { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn",   { bg = "NONE" })
        vim.api.nvim_set_hl(0, "LineNr",       { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WinBar",       { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WinBarNC",     { bg = "NONE" })
        vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE" })
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "" and vim.bo.filetype ~= "NvimTree" then
            pcall(vim.cmd, "cd " .. vim.fn.expand("%:p:h"))
        end
    end,
})
