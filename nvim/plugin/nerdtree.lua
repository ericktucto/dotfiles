vim.g.NERDTreeDirArrowExpandable = ''
vim.g.NERDTreeDirArrowCollapsible = ''
vim.g.NERDTreeGitStatusUseNerdFonts = 1
vim.g.NERDTreeShowLineNumber = 1
vim.cmd([[
  autocmd FileType nerdtree setlocal relativenumber
]])

local mapper = function (mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true})
end


mapper('', '<c-x>', ':NERDTreeToggle<CR>')
mapper("", "<Leader>n", ':NERDTreeFind<CR>')

