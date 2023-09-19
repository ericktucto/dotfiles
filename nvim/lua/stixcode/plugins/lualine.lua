return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    { require("stixcode.dependencies.devicons") },
  },
  opts = {
    options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "|", right = "|" }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
          {'filename', path = 1, symbols = { modified = ' ', readonly = ' ' } },
        },
        lualine_c = {
          {
            'diagnostics',
            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
            sources = { 'nvim_lsp' },
            sections = { 'error', 'warn', 'info', 'hint' },
            symbols = {error = ' ', warn = ' ', info = ' ', hint = '󰌵 '},
            colored = true,
            update_in_insert = true,
            always_visible = false,   -- Show diagnostics even if there are none.
          },
          -- {'NearestMethodOrFunction'}
        },
        lualine_x = {},
        lualine_y = {
          {
            'diff',
          },
          'branch'
        },
        lualine_z = {{'location', padding = 1}}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    }
}
}
