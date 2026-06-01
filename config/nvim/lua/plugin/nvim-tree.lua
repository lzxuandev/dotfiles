require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},

	sort = {
		sorter = "name", -- Sort by name
		folders_first = true, -- Set to false to prioritize files
		files_first = false, -- Some versions support this explicitly
	},

	filters = {
		dotfiles = false,
	},

	renderer = {
		indent_width = 3,
		indent_markers = {
			enable = false, -- Shows vertical lines for indentation
			inline_arrows = true, -- Places folder arrows inline with markers
		},
		icons = {
			web_devicons = {
				file = {
					enable = false,
				},
				folder = {
					enable = false,
				},
			},
			show = {
				file = true, -- 不显示文件图标ok
				folder = true, -- 不显示文件夹图标
				folder_arrow = true, -- 显示文件夹展开箭头
				git = false, -- 显示 git 状态图标
			},
		},
	},

	view = {
		width = 40, -- 文件树宽度（列数）
		side = "right", -- 显示在左侧
	},

	sync_root_with_cwd = true, -- 跟随当前工作目录 (cwd)
	respect_buf_cwd = true, -- 使用 buffer 的 cwd
	update_cwd = true, -- 切换文件时更新 cwd

	update_focused_file = {
		enable = true, -- 自动聚焦当前文件
		update_cwd = true, -- 同步 cwd
		update_root = true, -- 更新 tree root
	},
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = "#C2C2C2", bg = "#000000" })
vim.api.nvim_set_hl(0, "NvimTreeFolderName", { bold = true })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { bold = true, italic = true })
vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "#98c379" })
vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#EEEEEE", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeFileIcon", { bg = None })

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
	callback = function(data)
		local tree_api = require("nvim-tree.api")
		local hl = vim.api.nvim_get_hl(0, { name = "Cursor", link = false })
		if tree_api.tree.is_tree_buf(data.buf) then
			vim.api.nvim_set_hl(0, "Cursor", { blend = 100, fg = hl.fg, bg = hl.bg })
			vim.opt_local.guicursor:append("a:Cursor/lCursor")
		else
			vim.api.nvim_set_hl(0, "Cursor", { blend = 0, fg = hl.fg, bg = hl.bg })
			vim.opt_local.guicursor:remove("a:Cursor/lCursor")
		end
	end,
})
