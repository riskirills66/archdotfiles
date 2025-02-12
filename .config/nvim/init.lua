require("keymaps")
require("options")
require("config.lazy")
require("plugins.keymaps")
require("plugins.options")
require("core.mappings")

-- Default to system clipboard
vim.opt.clipboard = "unnamedplus"

-- Lua Line Function
-- -- Function to check if running in WSL
-- local function is_wsl()
--     local f = io.open("/proc/version", "r")
--     if f then
--         local content = f:read("*all")
--         f:close()
--         return content:match("Microsoft") or content:match("WSL")
--     end
--     return false
-- end
--
-- if is_wsl() then
--     -- Use win32yank for Windows clipboard in WSL
--     vim.g.clipboard = {
--         name = "win32yank",
--         copy = {
--             ["+"] = "win32yank.exe -i",
--             ["*"] = "win32yank.exe -i",
--         },
--         paste = {
--             ["+"] = "win32yank.exe -o",
--             ["*"] = "win32yank.exe -o",
--         },
--         cache_enabled = 0,
--     }
-- else
--     -- Use xclip or wl-clipboard for Linux (Hyprland/Wayland)
--     vim.g.clipboard = {
--         name = "xclip",
--         copy = {
--             ["+"] = "xclip -selection clipboard",
--             ["*"] = "xclip -selection primary",
--         },
--         paste = {
--             ["+"] = "xclip -selection clipboard -o",
--             ["*"] = "xclip -selection primary -o",
--         },
--         cache_enabled = 0,
--     }
-- end

vim.opt.termguicolors = false  -- Disable GUI colors, force terminal colors
vim.cmd([[
  set t_Co=256
  hi Normal ctermbg=NONE ctermfg=NONE
  hi NonText ctermbg=NONE ctermfg=NONE
  hi LineNr ctermbg=NONE ctermfg=NONE
  hi SignColumn ctermbg=NONE ctermfg=NONE
]])

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
