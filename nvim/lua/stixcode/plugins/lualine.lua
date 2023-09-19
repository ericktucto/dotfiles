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
