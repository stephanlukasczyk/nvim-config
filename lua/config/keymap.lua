local bind = vim.keymap.set
local noremap = { noremap = true }

-- Set the leader key to ,
vim.g.mapleader = ","
-- Set the leader-key timeout
vim.o.tm = 2000

-- Bindings for spellchecking
bind("", "<leader>ss", ":setlocal spell!<CR>")
bind("", "<F5>", ":setlocal spell! spelllang=en_gb<cr>")
bind("", "<F6>", ":setlocal spell! spelllang=de_de<cr>")

-- Copy and paste to macOS clipboard
bind("n", "<leader>y", "*y")
bind("v", "<leader>y", "*y")
bind("d", "<leader>y", "*d")
bind("d", "<leader>y", "*d")
bind("p", "<leader>y", "*p")
bind("p", "<leader>y", "*p")

-- Treat long lines as break lines
bind("n", "j", "gj", noremap)
bind("n", "k", "gk", noremap)

bind("", "<c-h>", "<c-w>h", noremap)
bind("", "<c-j>", "<c-w>j", noremap)
bind("", "<c-k>", "<c-w>k", noremap)
bind("", "<c-l>", "<c-w>l", noremap)
