local colors = {
    blue = "#14747e",
    red = "#ff5a67",
    yellow = "#ffcc1b",
    green = "#7fc06e",
    orange = "#f08e48",
    violet = "#c43060",
    purple = "#9a7044",
    cyan = "#5dd7b9",
    white = "#fafaf8",
    white_lite = "#e6e6dc",
    gray = "#a1a19a",
    gray_s = "#869696",
    gray_m = "#6c8b91",
    gray_l = "#517f8d",
    dark_lite = "#00384d",
    dark = "#002635",
    bg = "#051b26"
}
local atlas_theme = {
  normal = {
    a = { fg = colors.white, bg = colors.violet },
    b = { fg = colors.white, bg = colors.bg },
    c = { fg = colors.green, bg = colors.bg },
  },

  insert = { a = { fg = colors.bg, bg = colors.yellow } },
  visual = { a = { fg = colors.bg, bg = colors.orange } },
  replace = { a = { fg = colors.white, bg = colors.blue } },

  inactive = {
    c = { fg = colors.white, bg = colors.bg },
  },
}

require('lualine').setup {
    options = {
        theme = atlas_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "|", right = "|" }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
          {'filename', path = 1, symbols = { modified = ' ', readonly = ' ' } },
        },
        lualine_c = {
          {'NearestMethodOrFunction'}
        },
        lualine_x = {},
        lualine_y = {
          {
            'diff',
            diff_color = {
              added = { fg = "#7fc06e" },
              modified = { fg = "#ffcc1b" },
              removed = { fg = "#ff5a67" }
            }
          },
          'kite#statusline',
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
