vim.pack.add({"https://github.com/nvim-tree/nvim-tree.lua"})
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive", 
    },

    view = {
        width = 30,             
        side = "left",
        cursorline = true,  
    },

    renderer = {
        group_empty = true,     
        root_folder_label = ":t",  
    },

    filters = {
        dotfiles = true,   
    },

    actions = {
        open_file = {
            quit_on_open = true,
        }
    }

})

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true, desc = 'Toggle NvimTree' })

