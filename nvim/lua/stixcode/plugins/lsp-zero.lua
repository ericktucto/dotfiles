return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- support to LSP
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- autocomplete
    {
      'hrsh7th/nvim-cmp',
      config = function ()
        local cmp = require('cmp')

        cmp.setup({
          mapping = {
            -- `Enter` key to confirm completion
            ['<CR>'] = cmp.mapping.confirm({select = false}),

            -- Ctrl+Space to trigger completion menu
            ['<C-Space>'] = cmp.mapping.complete(),

            -- Navigation to next suggestion
            ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          }
        })
      end
    },
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
  }
}
