vim.o.shell = "/usr/bin/xonsh"
-- WildIgnore Stuff
local wildignored = {
  '*/tmp/*',
  '*.so',
  '*.swp',
  '*.zip',
  '*.rar',
  '*/__pycache__/*',
  'build.?/*',
  '*/.git/*',
}

local wildignore = ''
for i = 1, #wildignored do
  wildignore = wildignore .. wildignored[i] .. ','
end

-- Finally, set wildignore...
vim.o.wildignore = wildignore

vim.o.autoindent =  true
vim.bo.autoindent =  true

vim.o.expandtab =  true
vim.bo.expandtab =  true

vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4

vim.o.softtabstop = 4
vim.bo.softtabstop = 4

vim.o.tabstop = 4
vim.bo.tabstop = 4

vim.wo.number = true
vim.o.number = true
vim.wo.relativenumber = true
vim.o.relativenumber = true

vim.o.updatetime = 100
