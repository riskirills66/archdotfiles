require("keymaps")
require("options")
require("config.lazy")
require("plugins.keymaps")
require("plugins.options")
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard

vim.opt.termguicolors = false  -- Disable GUI colors, force terminal colors
vim.cmd([[
  set t_Co=256
  hi Normal ctermbg=NONE ctermfg=NONE
  hi NonText ctermbg=NONE ctermfg=NONE
  hi LineNr ctermbg=NONE ctermfg=NONE
  hi SignColumn ctermbg=NONE ctermfg=NONE
]])
