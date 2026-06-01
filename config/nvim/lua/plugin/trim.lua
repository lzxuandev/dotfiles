
require('trim').setup({
    -- if you want to ignore markdown file.
    -- you can specify filetypes.
    ft_blocklist = {"markdown"},

    -- if you want to remove multiple blank lines
    patterns = {
    [[%s/\(\n\n\)\n\+/\1/]],   
    },

    trim_on_write = true,
    trim_trailing = true,
    trim_last_line = true,
    trim_first_line = true,
    trim_current_line = true,
    highlight = false,
    highlight_bg = '#000000', -- or 'red'
    highlight_ctermbg = 'black',
    notifications = true,
})
