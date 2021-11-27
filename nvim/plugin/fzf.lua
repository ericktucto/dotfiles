-- MODOS PARA LA BUSQUEDA DE ARCHIVOS EN UN PROYECTO
function Searching(view)
  if (view == 'git') then
    vim.fn["fzf#run"]({
      options = { '--layout=reverse', '--preview', 'batcat -n --color=always {}' },
      window = { width = 1, height = 1 },
      source = 'find . -name "*.*" -type f -not -path "./.git/*" -not -path "./vendor/*" -not -path "./node_modules/*"',
      sink = "e"
    })
  elseif (view == 'buffer') then
    vim.fn['fzf#vim#buffers']({
        options = { '--layout=reverse' },
        window = { width = 0.5, height = 0.5 }
      })
  end
end

-- BUSCAR UNA PALABRA EN EL PROYECTO
function _G.FindWord(query, fullscreen)
  local excludedDir = { '.git', 'node_modules', 'vendor', 'storage', 'public' }
  local excludedDirString = ""
  for _, value in ipairs(excludedDir) do
    excludedDirString = excludedDirString .. string.format("--exclude-dir=%s  ", value)
  end

  local commandSearch = "grep %s -RHonia %s . || true"
  local initial_command = string.format(commandSearch, excludedDirString, "''")
  local reload_command = string.format(commandSearch, excludedDirString, '{q}')

  local preview = string.format('%s/scripts/previewer {}', vim.fn.stdpath('config'))
  local spec = {
    options = {
      '--phony',
      '--query',
      query,
      '--bind',
      'change:reload:' .. reload_command,
      '--layout=reverse',
      '--preview',
      preview
    },
    window = { width = 1, height = 1 }
  }
  vim.fn['fzf#vim#grep'](initial_command, 1, spec, fullscreen)
end

vim.cmd([[
  command! -nargs=* -bang FWord lua FindWord(<q-args>, <bang>0)
]])

local mapper = function (mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true})
end
mapper("n", "<c-p>", [[<cmd>lua Searching('git')<CR>]])
mapper("n", "<Leader>p", [[<cmd>lua Searching('buffer')<CR>]])
mapper("", "<Leader>f", ":FWord<CR>")
mapper("i", "<Leader>f", "<Esc> :FWord<CR>")
