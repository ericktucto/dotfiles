return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  keys = {
    { '<C-x>', ':NvimTreeToggle<CR>', desc = "Alternar explorador de archivos" },
    { "<leader>n", ":NvimTreeFindFile<cr>", desc = "Revelar en el explorador de archivos" },
  },
  dependencies = {
    { require("stixcode.dependencies.devicons"), },
  },
  opts = {
    sort_by = "case_sensitive",
    view = {
      adaptive_size = true,
      mappings = {
        list = {
          { key = "u", action = "dir_up" },
        },
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  }
}
