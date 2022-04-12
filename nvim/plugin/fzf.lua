local fzf = require("fzf")
-- MODOS PARA LA BUSQUEDA DE ARCHIVOS EN UN PROYECTO
function Searching(view)
  if (view == 'git') then
    local excludedDir = table.concat({
      "",
      '"./.expo/*"',
      '"./.expo-shared/*"',
      '"./.git/*"',
      '"./vendor/*"',
      '"./node_modules/*"',
      '"./docker/*"',
    }, " -not -path ")
    vim.fn["fzf#run"]({
      options = { '--layout=reverse', '--preview', 'batcat -n --color=always {}' },
      window = { width = 1, height = 1 },
      source = 'find . -name "*.*" -type f'..excludedDir,
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
  local excludedDir = table.concat({
    "",
    '.git',
    'node_modules',
    'vendor',
    'storage',
    'public',
    'docker',
    'expo',
    'expo-shared'
  }, " --exclude-dir=")
  local commandSearch = "grep %s -RHonia %s . || true"
  local initial_command = string.format(commandSearch, excludedDir, "''")
  local reload_command = string.format(commandSearch, excludedDir, '{q}')

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

-- ESTA FUNCION LISTA MIS PROYECTOS
function Projects()
  coroutine.wrap(function()
    local projects = require('project_nvim').get_recent_projects()
    local result = fzf.fzf(projects, "--ansi --layout=reverse --prompt='Elige un proyecto >>> '", { border = false })
    if result then
      require('project_nvim.project').set_pwd(result[1], "stixcode")
      vim.fn["NERDTreeCWD"]()
    else
      print("Hubo un fallo")
    end
  end)()
end

local mapper = function (mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true})
end
mapper("n", "<c-p>", [[<cmd>lua Searching('git')<CR>]])
mapper("n", "<Leader>p", [[<cmd>lua Searching('buffer')<CR>]])
mapper("", "<Leader>f", ":FWord<CR>")
mapper("i", "<Leader>f", "<Esc> :FWord<CR>")
mapper("n", "<Leader>k", [[<cmd>lua Projects()<CR>]])

