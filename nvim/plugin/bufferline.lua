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

local mapper = function (mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true})
end

-- NEXT, PREVIOUS BUFFER
mapper("", "<c-k>", ":bnext<CR>")
mapper("i", "<c-k>", "<Esc> :bnext<CR>i")
mapper("", "<c-j>", ":bprevious<CR>")
mapper("i", "<c-j>", "<Esc> :bprevious<CR>i")

-- SAVE BUFFER
mapper("", "<Leader>h", ":update<CR>")
mapper("v", "<Leader>h", "<C-C> :update<CR>")
mapper("i", "<Leader>h", "<Esc> <C-O> :update<CR>")
mapper("", "<Leader>H", ":update!<CR>")
mapper("v", "<Leader>H", "<C-C> :update!<CR>")
mapper("i", "<Leader>H", "<Esc> <C-O> :update!<CR>")

-- CLOSE BUFFER
mapper("", "<Leader>j", ":bd<CR>")
mapper("v", "<Leader>j", "<C-C> :bd<CR>")
mapper("i", "<Leader>j", "<Esc> <C-O> :bd<CR>")
mapper("", "<Leader>J", ":bd!<CR>")
mapper("v", "<Leader>J", "<C-C> :bd!<CR>")
mapper("i", "<Leader>J", "<Esc> <C-O> :bd!<CR>")

-- CLOSE ALL BUFFER
mapper("", "<Leader>u", ":%bdele<CR>")
mapper("v", "<Leader>u", "<C-C> :%bdele<CR>")
mapper("i", "<Leader>u", "<Esc> <C-O> :%bdele<CR>")
mapper("", "<Leader>U", ":%bdele!<CR>")
mapper("v", "<Leader>U", "<C-C> :%bdele!<CR>")
mapper("i", "<Leader>U", "<Esc> <C-O> :%bdele!<CR>")
