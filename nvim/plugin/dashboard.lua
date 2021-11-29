vim.g.dashboard_custom_section = {
-- Jump to bookmarks                     SPC f b
-- Recently opened files                 SPC f h
-- Open last session                     SPC s l
-- New file                              SPC c n
  find_file = {
    description = {' Find file                Ctrl+h p'},
    command = [[lua Searching('git')]]
  },
  find_word = {
    description = {' Find word                Ctrl+h f'},
    command = 'FWord'
  },
  open_projects = {
    description = {' Abrir proyecto           Ctrl+h k'},
    command = [[lua Projects()]]
  }
}
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
