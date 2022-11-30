vim.g.dashboard_custom_section = {
-- Jump to bookmarks                     SPC f b
-- Recently opened files                 SPC f h
-- Open last session                     SPC s l
-- New file                              SPC c n
  dashboard_find_file = { ' Buscar archivo           Ctrl p  ' },
  dashboard_find_word = { ' Buscar palabra           Ctrl h f' },
  dashboard_open_project = { ' Abrir proyecto           Ctrl h k' },
}

vim.cmd([[
  function! DASHBOARD_FIND_FILE()
    lua Searching('git')
  endfunction
  function! DASHBOARD_FIND_WORD()
    FWord
  endfunction
  function! DASHBOARD_OPEN_PROJECT()
    lua Projects()
  endfunction
]])

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
