local blink_capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('clangd', {
    cmd = {
        "clangd",
        "--function-arg-placeholders=false"
    },
    root_markers = { '.git', 'compile_commands.json', 'build' },
    capabilities = blink_capabilities,
})

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    root_markers = { '.git', 'lua' },
    capabilities = blink_capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } }
        }
    }
})

vim.lsp.enable({ 'clangd', 'lua_ls' })

vim.diagnostic.config({
    virtual_text  = false,
    virtual_lines = false,
    signs         = false,
    underline     = true
})

-- 定义切换诊断显示的函数
local function toggle_virtual_text()
    local config = vim.diagnostic.config()
    local new_value = not config.virtual_text

    vim.diagnostic.config({
        virtual_text = new_value,
        -- 确保其他配置保持不变
        virtual_lines = false,
        signs = false,
        underline = true
    })

    -- 给用户一个视觉反馈
    local status = new_value and "开启" or "关闭"
    vim.notify("诊断 Virtual Text 已" .. status, vim.log.levels.INFO)
end

vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
    toggle_virtual_text()
end, { desc = "跳转定义并切换 Virtual Text 显示" })
