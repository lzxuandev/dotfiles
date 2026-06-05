vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = "#222222" })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = "#222222" })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { bg = "#222222" })
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#222222" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "#1e1e1e", fg = "#444444" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#373737", bold = true })

require('blink.cmp').setup({
    keymap = { preset = 'super-tab' },

    appearance = {
        nerd_font_variant = 'mono'
    },
    cmdline = {
        completion = {
            menu = {
                auto_show = true
            }
        }
    },

    completion = {
        menu = {
            auto_show = true,
            auto_show_delay_ms = 3000,

            max_height = 5,
            scrollbar = false,
            direction_priority = { 'n', 's' },
            draw = {
                -- Aligns the keyword you've typed to a component in the menu
                align_to = 'label', -- or 'none' to disable, or 'cursor' to align to the cursor
                -- Left and right padding, optionally { left, right } for different padding on each side
                padding = 2,
                -- Gap between columns
                gap = 2,
                -- Priority of the cursorline highlight, setting this to 0 will render it below other highlights
                cursorline_priority = 10000,
                -- Appends an indicator to snippets label
                snippet_indicator = '~',
                -- Use treesitter to highlight the label text for the given list of sources
                treesitter = { 'lsp' },
                -- treesitter = { 'lsp' }

                -- Components to render, grouped by column
                columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },

                -- Definitions for possible components to render. Each defines:
                --   ellipsis: whether to add an ellipsis when truncating the text
                --   width: control the min, max and fill behavior of the component
                --   text function: will be called for each item
                --   highlight function: will be called only when the line appears on screen
                components = {
                    kind_icon = {
                        ellipsis = false,
                        text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
                        -- Set the highlight priority to 20000 to beat the cursorline's default priority of 10000
                        highlight = function(ctx) return { { group = ctx.kind_hl, priority = 20000 } } end,
                    },

                    kind = {
                        ellipsis = false,
                        width = { fill = true },
                        text = function(ctx) return ctx.kind end,
                        highlight = function(ctx) return ctx.kind_hl end,
                    },

                    label = {
                        width = { fill = true, max = 60 },
                        text = function(ctx) return ctx.label .. ctx.label_detail end,
                        highlight = function(ctx)
                            -- label and label details
                            local highlights = {
                                { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
                            }
                            if ctx.label_detail then
                                table.insert(highlights,
                                    { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' })
                            end

                            -- characters matched on the label by the fuzzy matcher
                            for _, idx in ipairs(ctx.label_matched_indices) do
                                table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                            end

                            return highlights
                        end,
                    },

                    label_description = {
                        width = { max = 30 },
                        text = function(ctx) return ctx.label_description end,
                        highlight = 'BlinkCmpLabelDescription',
                    },

                    source_name = {
                        width = { max = 30 },
                        text = function(ctx) return ctx.source_name end,
                        highlight = 'BlinkCmpSource',
                    },

                    source_id = {
                        width = { max = 30 },
                        text = function(ctx) return ctx.source_id end,
                        highlight = 'BlinkCmpSource',
                    },
                },
            }
        },

        documentation = { auto_show = true, auto_show_delay_ms = 3000 },

        ghost_text = { enabled = true , show_with_menu = false},
    },

    signature = {
        enabled = true,
        trigger = {
            enabled = true,
        },
        window = {
            border = "rounded",
            direction_priority = { 's', 'n' },
            treesitter_highlighting = true,
            show_documentation = false,
        },
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = {
        implementation = "lua"
    }
})
