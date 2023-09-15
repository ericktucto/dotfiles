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
return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "VeryLazy",
  keys = {
    -- NEXT, PREVIOUS BUFFER
    { "<c-k>", ":bnext<CR>", desc = "Siguiente buffer" },
    { "<c-k>", "<Esc> :bnext<CR>i", desc = "Siguiente buffer", mode = "i" },
    { "<c-j>", ":bprevious<CR>", desc = "Anterior buffer" },
    { "<c-j>", "<Esc> :bprevious<CR>i", desc = "Anterior buffer", mode = "i" },

    -- SAVE BUFFER
    { "<Leader>h", ":update<CR>", desc = "Guardar buffer" },
    { "<Leader>h", "<C-C> :update<CR>", desc = "Guardar buffer", mode = "v" },
    -- { "<Leader>h", "<Esc> <C-O> :update<CR>", desc = "Guardar buffer", mode = "i" },
    { "<Leader>H", ":update!<CR>", desc = "Guardar buffer" },
    { "<Leader>H", "<C-C> :update!<CR>", desc = "Guardar buffer", mode = "v" },
    -- { "<Leader>H", "<Esc> <C-O> :update!<CR>", desc = "Guardar buffer", mode = "i" },

    -- CLOSE BUFFER
    { "<Leader>j", ":bd<CR>", desc = "buffer" },
    { "<Leader>j", "<C-C> :bd<CR>", desc = "buffer", mode = "v" },
    -- { "<Leader>j", "<Esc> <C-O> :bd<CR>", desc = "buffer", mode = "i" },
    { "<Leader>J", ":bd!<CR>", desc = "buffer" },
    { "<Leader>J", "<C-C> :bd!<CR>", desc = "buffer", mode = "v" },
    -- { "<Leader>J", "<Esc> <C-O> :bd!<CR>", desc = "buffer", mode = "i" },

    -- CLOSE ALL BUFFER
    { "<Leader>u", ":%bdele<CR>", desc = "buffer" },
    { "<Leader>u", "<C-C> :%bdele<CR>", desc = "buffer", mode = "v" },
    -- { "<Leader>u", "<Esc> <C-O> :%bdele<CR>", desc = "buffer", mode = "i" },
    { "<Leader>U", ":%bdele!<CR>", desc = "buffer" },
    { "<Leader>U", "<C-C> :%bdele!<CR>", desc = "buffer", mode = "v" },
    -- { "<Leader>U", "<Esc> <C-O> :%bdele!<CR>", desc = "buffer", mode = "i" },

  },
  opts = {
    highlights = {
     -- ESTA ES LA AREA DONDE NO ESTAN LOS BUFFER
      fill = {
        bg = colors.bg
      },
      -- ESTOS SON LAS BUFFER INACTIVAS
      background = {
        fg = colors.gray,
        bg = colors.bg
      },
      -- TODOS LOS BOTON DE CERRAR PERO DE LOS BUFFER INACTIVOS
      close_button = {
        fg = colors.red,
        bg = colors.bg
      },
      close_button_selected = {
        fg = colors.red,
        bg = normal_bg
      },
      buffer_selected = {
        fg = colors.white,
        bg = normal_bg,
        italic = true
      },
      -- ES PARA EL BOTON DE CERRAR NEOVIM
      tab_close = {
        fg = colors.bg,
        bg = colors.bg,
      },
      separator = {
        fg = colors.gray_m,
        bg = colors.bg,
      },
      indicator_selected = {
        fg = colors.dark,
        bg = colors.dark,
      },
      modified = {
        fg = normal_fg,
        bg = colors.bg,
      },
      error = {
        fg = colors.red,
        bg = colors.bg
      },
      error_diagnostic = {
        fg = colors.red,
        bg = colors.bg
      },
      warning = {
        fg = colors.yellow,
        bg = colors.bg
      },
      warning_diagnostic = {
        fg = colors.yellow,
        bg = colors.bg
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
}
