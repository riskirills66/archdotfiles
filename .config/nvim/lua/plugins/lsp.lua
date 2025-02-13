return {
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      lazy = true,
      config = false,
      init = function()
        vim.g.lsp_zero_extend_cmp = 0
        vim.g.lsp_zero_extend_lspconfig = 0
      end,
    },
    {
      'williamboman/mason.nvim',
      lazy = false,
      config = true,
    },
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        { 'L3MON4D3/LuaSnip' },
      },
      config = function()
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_cmp()
        local cmp = require('cmp')
        local cmp_action = lsp_zero.cmp_action()
        cmp.setup({
          formatting = lsp_zero.cmp_format({ details = true }),
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-f>'] = cmp_action.luasnip_jump_forward(),
            ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          }),
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          },
        })
      end
    },
    {
      'neovim/nvim-lspconfig',
      cmd = {'LspInfo', 'LspInstall', 'LspStart'},
      event = {'BufReadPre', 'BufNewFile'},
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'williamboman/mason-lspconfig.nvim',
      },
      config = function()
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_lspconfig()

        require('mason-lspconfig').setup({
          ensure_installed = {
            'lua_ls',  -- For Lua
            -- Add other language servers you need here
          },
          handlers = {
            lsp_zero.default_setup,
            lua_ls = function()
              require('lspconfig').lua_ls.setup({
                settings = {
                  Lua = {
                    diagnostics = {
                      globals = { 'vim' }
                    },
                    workspace = {
                      library = vim.api.nvim_get_runtime_file("", true),
                      checkThirdParty = false,
                    }
                  }
                }
              })
            end,
          }
        })
      end
    },
  }