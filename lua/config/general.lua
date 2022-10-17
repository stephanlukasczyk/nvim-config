-- Automatically reload if the file changes externally
vim.o.autoread = true

-- Allow the normal use of "," by hitting it twice
vim.keymap.set("n", ",,", ",")

-- Use par for prettier line formatting
vim.o.formatprg = "par"
vim.fn.setenv("PARINIT", "rTbgqR B=.,?_A_a Q=_s>|")

-- Set 7 lines to the cursor when moving with j/k
vim.o.so = 7

-- Always show the current position
vim.o.ruler = true
vim.o.number = true
vim.o.relativenumber = true

-- Show relevant white spaces
vim.opt.listchars = { tab = '▸ ', trail = '·' }

-- Height of command bar
vim.o.cmdheight = 1

-- Configure backspace, thus it acts as it should act
vim.o.backspace = "indent,eol,start"
vim.o.whichwrap = "b,s,<,>,h,l"

-- Ignore case while searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight search results
vim.o.hlsearch = true

-- Make search behave like in modern browsers
vim.o.incsearch = true

-- Do not redraw while executing macros
vim.o.lazyredraw = true

-- For regular expressions turn magic on
vim.o.magic = true

-- Show matching brackets when cursor is over
vim.o.showmatch = true

-- Toggle and set mouse mode
vim.keymap.set("n", "<leader>ma", function()
  vim.o.mouse = "a"
end)
vim.keymap.set("n", "<leader>mo", function()
  vim.o.mouse = ""
end)
vim.o.mouse = "a"

vim.cmd [[
  filetype on
  filetype plugin on
  filetype plugin indent on
  syntax on
]]

-- Turn of backup, since most stuff is in Git anyway...
vim.o.backup = false
vim.o.wb = false
vim.o.swapfile = false

-- Use spaces instead of tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Set line break at 80 characters
vim.opt.linebreak = true
vim.opt.textwidth = 80
vim.opt.breakindent = true

-- Smart auto indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true
