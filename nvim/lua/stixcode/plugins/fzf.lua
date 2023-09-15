-- MODOS PARA LA BUSQUEDA DE ARCHIVOS EN UN PROYECTO
function Searching(view)
  if (view == 'git') then
    local excludedDir = table.concat({
      "",
      '"./.expo/*"',
      '"./target/*"',
      '"./venv/*"',
      '"./.expo-shared/*"',
      '"./.git/*"',
      '"./vendor/*"',
      '"*/node_modules/*"',
      '"./docker/*"',
      '"./coverage/*"',
      '"./clockwork/*"',
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
        window = { width = 1, height = 1 }
      })
  elseif (view == 'git-status') then
    vim.fn["fzf#run"]({
      options = { '--layout=reverse', '--preview', 'batcat -n --color=always {}' },
      window = { width = 1, height = 1 },
      source = string.format('%s/scripts/gitstatus.py', vim.fn.stdpath('config')),
      sink = "e"
    })
  end
end

function FindWord(query, fullscreen)
  local excludedDir = table.concat({
    "",
    '.git',
    'venv',
    'node_modules',
    'vendor',
    'storage',
    'public',
    'docker',
    'expo',
    'clockwork',
    'expo-shared',
    'coverage',
    'target'
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

-- ESTA FUNCION LISTA MIS PROYECTOS
function Projects()
  coroutine.wrap(function()
    local fzf = require("fzf")
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
return {
  "junegunn/fzf.vim",
  dependencies = {
    { "junegunn/fzf" }
  },
  keys = {
    { "<c-p>", function() Searching("git") end, desc = "Buscar en el proyecto" },
    { "<Leader>s", function() Searching('git-status') end, desc = "Buscar en el stage de git" },
    { "<Leader>p", function() Searching('buffer') end, desc = "Buscar entre los buffer" },



    -- { "<Leader>k", "<cmd>lua Projects()<CR>", desc = "Abrir proyecto..." },
    -- { "<Leader>f", "<cmd>FWord<CR>", desc = "Buscar una palabra en el proyecto" },
    -- { "<Leader>f", "<Esc> :FWord<CR>", desc = "Buscar una palabra en el proyecto", mode = "i" }
  }
}
