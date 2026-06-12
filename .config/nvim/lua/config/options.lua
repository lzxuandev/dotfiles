vim.g.netrw_banner     = 0

vim.opt.number          = true
vim.opt.relativenumber  = false
vim.opt.cursorline      = false
vim.opt.wrap            = false
vim.opt.ruler           = false
vim.opt.laststatus      = 0
vim.opt.showcmd         = false
vim.opt.cmdheight       = 0
vim.opt.winbar          = " "
vim.opt.statusline      = ""
vim.opt.numberwidth     = 4
vim.opt.termguicolors   = true
vim.opt.splitbelow      = true
vim.opt.splitright      = true
vim.opt.inccommand      = "split"

vim.opt.scrolloff       = 20     -- keep cursor center when mouse vertical scroll
vim.opt.sidescrolloff   = 30     -- keep cursor center when mouse horizontal scroll
vim.opt.tabstop         = 4      -- tabwidth
vim.opt.shiftwidth      = 4      -- indent width
vim.opt.softtabstop     = 4      -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab       = true   -- use spaces instead of tabs
vim.opt.smartindent     = true   -- smart auto-indent
vim.opt.autoindent      = true   -- copy indent from current line

vim.opt.ignorecase      = true   -- case insensitive search
vim.opt.smartcase       = true   -- case sensitive if uppercase in string
vim.opt.hlsearch        = true   -- highlight search matches
vim.opt.incsearch       = true   -- show matches as you type

vim.opt.confirm         = false
vim.opt.signcolumn      = "yes"  -- always show a sign column
vim.opt.colorcolumn     = "0"    -- show a column at 100 position chars
vim.opt.showmatch       = false  -- highlights matching brackets
vim.opt.showmode        = false  -- do not show the mode, instead have it in statusline
vim.opt.pumheight       = 10     -- popup menu height
vim.opt.pumblend        = 10     -- popup menu transparency
vim.opt.fillchars       = { eob = " " } -- hide "~" on empty lines

vim.opt.undodir         = vim.fn.stdpath("data") .. "/undodir"
vim.opt.backup          = false                  -- do not create a backup file
vim.opt.writebackup     = false                  -- do not write to a backup file
vim.opt.swapfile        = false                  -- do not create a swapfile
vim.opt.undofile        = true                   -- do create an undo file
vim.opt.updatetime      = 300                    -- faster completion
vim.opt.timeoutlen      = 500                    -- timeout duration
vim.opt.ttimeoutlen     = 50                     -- key code timeout
vim.opt.autoread        = true                   -- auto-reload changes if outside of neovim
vim.opt.autowrite       = false                  -- do not auto-save

vim.opt.hidden          = true                   -- allow hidden buffers
vim.opt.errorbells      = false                  -- no error sounds
vim.opt.backspace       = "indent,eol,start"     -- better backspace behaviour
vim.opt.autochdir       = false                  -- do not autochange directories
vim.opt.selection       = "inclusive"            -- include last char in selection
vim.opt.mouse           = "a"                    -- enable mouse support
vim.opt.modifiable      = true                   -- allow buffer modifications
vim.opt.encoding        = "utf-8"                -- set encoding
vim.opt.clipboard:append("unnamedplus")          -- use system clipboard
vim.opt.iskeyword:append("-")                    -- include - in words
vim.opt.path:append("**")                        -- include subdirs in search

