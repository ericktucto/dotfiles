-- ELIMINAR LOS BOTONES DE CERRAR DE LOS BUFFER DE bufferline.nvim
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
require("bufferline").setup {
  highlights = {
   -- ESTA ES LA AREA DONDE NO ESTAN LOS BUFFER
    fill = {
      guibg = colors.bg
    },
    -- ESTOS SON LAS BUFFER INACTIVAS
    background = {
      guifg = colors.gray,
      guibg = colors.bg
    },
    -- TODOS LOS BOTON DE CERRAR PERO DE LOS BUFFER INACTIVOS
    close_button = {
      guifg = colors.red,
      guibg = colors.bg
    },
    close_button_selected = {
      guifg = colors.red,
      guibg = normal_bg
    },
    buffer_selected = {
      guifg = colors.white,
      guibg = normal_bg,
      gui = "bold,italic"
    },
    -- ES PARA EL BOTON DE CERRAR NEOVIM
    tab_close = {
      guifg = colors.bg,
      guibg = colors.bg,
    },
    separator = {
      guifg = colors.gray_m,
      guibg = colors.bg,
    },
    indicator_selected = {
      guifg = colors.dark,
      guibg = colors.dark,
    },
    modified = {
      guifg = normal_fg,
      guibg = colors.bg,
    },
    error = {
      guifg = colors.red,
      guibg = colors.bg
    },
    error_diagnostic = {
      guifg = colors.red,
      guibg = colors.bg
    },
    warning = {
      guifg = colors.yellow,
      guibg = colors.bg
    },
    warning_diagnostic = {
      guifg = colors.yellow,
      guibg = colors.bg
    }
  },
  options = {
    offsets = {
      {
        filetype = "nerdtree",
        text = "PROYECTO",
        highlight = "Directory",
        text_align = "center"
      }
    },
    separator_style = "thin",
    diagnostics = "coc",
    diagnostics_update_in_insert = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error"
            and ""
            or (e == "warning" and "" or "" )
            s = s .. n .. sym
      end
      return s
    end
  }
}
