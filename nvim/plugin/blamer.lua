vim.g.blamer_prefix = "🚀 "
vim.g.blamer_template = "<commit-short> <committer>, <committer-time> • <summary>"

local mapper = function (mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true})
end

mapper("", "<Leader>b", ":BlamerToggle<CR>")
