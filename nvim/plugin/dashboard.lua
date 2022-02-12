vim.g.dashboard_custom_section = {
-- Jump to bookmarks                     SPC f b
-- Recently opened files                 SPC f h
-- Open last session                     SPC s l
-- New file                              SPC c n
  find_file = {
    description = {' Buscar archivo           Ctrl p  '},
    command = [[lua Searching('git')]]
  },
  find_word = {
    description = {' Buscar palabra           Ctrl h f'},
    command = 'FWord'
  },
  open_projects = {
    description = {' Abrir proyecto           Ctrl h k'},
    command = [[lua Projects()]]
  }
}
vim.g.dashboard_preview_pipeline = 'lolcat'
vim.g.dashboard_custom_header = {
  '██╗   ██╗██╗███╗   ███╗ ██████╗ ██████╗ ██████╗ ███████╗',
  '██║   ██║██║████╗ ████║██╔════╝██╔═══██╗██╔══██╗██╔════╝',
  '██║   ██║██║██╔████╔██║██║     ██║   ██║██║  ██║█████╗',
  '╚██╗ ██╔╝██║██║╚██╔╝██║██║     ██║   ██║██║  ██║██╔══╝',
  ' ╚████╔╝ ██║██║ ╚═╝ ██║╚██████╗╚██████╔╝██████╔╝███████╗',
  '  ╚═══╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝'
}
vim.g.dashboard_custom_footer = {
  'Disfruta programando hoy'
}
