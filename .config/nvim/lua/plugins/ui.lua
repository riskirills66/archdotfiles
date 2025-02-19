return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					numbers = "none",
					close_command = "bdelete! %d",
					right_mouse_command = "bdelete! %d",
					left_mouse_command = "buffer %d",
					middle_mouse_command = nil,
					indicator = {
						icon = '▎',
						style = 'icon',
					},
					buffer_close_icon = '󰅖',
					modified_icon = '●',
					close_icon = '',
					left_trunc_marker = '',
					right_trunc_marker = '',
					show_buffer_icons = true,
					show_buffer_close_icons = true,
					show_close_icon = true,
					show_tab_indicators = true,
					separator_style = "thin",
					always_show_bufferline = true,
				}
			})
		end
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			messages = {
				enabled = true,
				view = "notify",
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
				view_search = "virtualtext",
			},
			notify = {
				enabled = true,
				view = "notify",
			},
			lsp = {
				message = {
					enabled = true,
				},
			},
			recording = {
				enabled = true,
				view = "notify",
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	},
}
