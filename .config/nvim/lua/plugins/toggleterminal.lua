return{
{
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15  -- Adjust height for horizontal split (like VS Code)
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.2  -- Adjust width for vertical split
        end
      end,
      open_mapping = [[<leader>']], -- VS Code uses Ctrl+`
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = false,
      shading_factor = 0,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal",  -- Default to horizontal (like VS Code)
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "rounded",
        winblend = 0,
      },
    })
        -- Auto command to allow <C-w> h/j/k/l in terminal mode
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*",
      callback = function()
        vim.cmd("startinsert") -- Ensure terminal starts in insert mode
        vim.keymap.set("t", "<C-w>h", [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
        vim.keymap.set("t", "<C-w>j", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
        vim.keymap.set("t", "<C-w>k", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
        vim.keymap.set("t", "<C-w>l", [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })
	vim.keymap.set("t", "<C-w>q", [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true }) -- Close terminal
      end,
    })
 
    -- Keymaps like VS Code
    -- vim.keymap.set("n", "<C-`>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("t", "<C-`>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })
    -- vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true }) -- Exit terminal mode
  end,
}
}
