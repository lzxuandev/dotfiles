vim.pack.add({"https://github.com/goolord/alpha-nvim"})
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

dashboard.section.header.opts.hl = "AlphaHeader"

vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#CCCCCC", })

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "n", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file", ":cd $HOME/ | Telescope find_files<CR>"),
    dashboard.button( "c", "  > Let's C",   ":cd $HOME/Programming/C/ | e main.c | NvimTreeRefresh<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":cd $HOME/.config/nvim/ | e init.lua | NvimTreeRefresh<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":quit<CR>"),

}

-- Send config to alpha
alpha.setup(dashboard.opts)
