return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  ensure_installed = {
    "lua",
    "luadoc",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "php",
    "phpdoc",
    "python",
    "rust",
    "bash",
    "css",
    "scss",
    "sql",
    "toml",
    "typescript",
    "vue",
    "diff",
  },
  highlight = {
    enable = true,
  },
}