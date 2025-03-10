require("keymaps")
require("options")
require("config.lazy")
require("core.mappings")

-- Default to system clipboard
vim.opt.clipboard = "unnamedplus"
vim.o.laststatus = 3

local pywal = require('pywal')

pywal.setup()

-- vim.cmd("silent! source ~/.cache/wal/colors-wal.vim")
--
-- local wal_colors = vim.fn.expand("~/.cache/wal/colors-wal.vim")
-- if vim.fn.filereadable(wal_colors) == 1 then
--     vim.cmd("source " .. wal_colors)
-- else
--     print("Pywal theme not found! Run 'wal' first.")
-- end
--
-- vim.api.nvim_create_user_command("ReloadPywal", function()
--     vim.cmd("source ~/.cache/wal/colors-wal.vim")
-- end, {})

-- -- Function to check if running in WSL
-- local function is_wsl()
-- 	local f = io.open("/proc/version", "r")
-- 	if f then
-- 		local content = f:read("*all")
-- 		f:close()
-- 		return content:match("Microsoft") or content:match("WSL")
-- 	end
-- 	return false
-- end
--
-- -- Function to check if clipboard tool is available
-- local function has_clipboard_tool(tool)
-- 	return vim.fn.executable(tool) == 1
-- end
--
-- -- Configure clipboard based on environment
-- if is_wsl() then
-- 	-- Use win32yank for Windows clipboard in WSL
-- 	if has_clipboard_tool('win32yank.exe') then
-- 		vim.g.clipboard = {
-- 			name = "win32yank",
-- 			copy = {
-- 				["+"] = "win32yank.exe -i",
-- 				["*"] = "win32yank.exe -i",
-- 			},
-- 			paste = {
-- 				["+"] = "win32yank.exe -o",
-- 				["*"] = "win32yank.exe -o",
-- 			},
-- 			cache_enabled = 0,
-- 		}
-- 	end
-- else
-- 	-- For Arch Linux, check and use available clipboard tool
-- 	if has_clipboard_tool('xclip') then
-- 		vim.g.clipboard = {
-- 			name = "xclip",
-- 			copy = {
-- 				["+"] = "xclip -selection clipboard",
-- 				["*"] = "xclip -selection primary",
-- 			},
-- 			paste = {
-- 				["+"] = "xclip -selection clipboard -o",
-- 				["*"] = "xclip -selection primary -o",
-- 			},
-- 			cache_enabled = 0,
-- 		}
-- 	elseif has_clipboard_tool('wl-copy') then
-- 		vim.g.clipboard = {
-- 			name = "wl-clipboard",
-- 			copy = {
-- 				["+"] = "wl-copy",
-- 				["*"] = "wl-copy",
-- 			},
-- 			paste = {
-- 				["+"] = "wl-paste",
-- 				["*"] = "wl-paste",
-- 			},
-- 			cache_enabled = 0,
-- 		}
-- 	end
-- end

-- vim.cmd([[
--  set t_Co=256
--  set notermguicolors
--  hi Normal ctermbg=NONE guibg=NONE
--  hi NonText ctermbg=NONE guibg=NONE
--  hi LineNr ctermbg=NONE guibg=NONE
--  hi SignColumn ctermbg=NONE guibg=NONE
--  hi NormalFloat ctermbg=NONE guibg=NONE
--  hi FloatBorder ctermbg=NONE guibg=NONE
-- ]])


require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'pywal',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = true,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		}
	},
	sections = {
		lualine_a = { { '', color = { fg = "#98c379" } }, 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = {
			'recording',
			'encoding', 'fileformat', 'filetype',
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#ff9e64" },
			}
		},
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
