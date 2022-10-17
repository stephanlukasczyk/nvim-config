vim.cmd [[
  colorscheme solarized
]]
vim.o.background = "dark"

vim.cmd [[
  hi! link SignColumn LineNr

  hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
  hi! link Visual Search

  hi Directory guifg=#8ac6f2

  hi Cursor guibg=red

  set guicursor=n-v-c:block-Cursor
  set guicursor+=n-v-c:blinkon0

  set t_Co=256
]]
