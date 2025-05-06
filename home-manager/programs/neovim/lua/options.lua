-- leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- number 
vim.o.nu = true
vim.o.relativenumber = true

-- tab
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- indent
vim.o.smartindent = false -- disabled for treesitter indent

-- line
vim.o.wrap = false

-- search
vim.o.ignorecase = true
vim.o.smartcase = true -- assume case sensitive when using mixed case

-- random
vim.g.lazygit_use_custom_config_file_path = 1
vim.g.lazygit_config_file_path = '~/nix-config/home-manager/programs/neovim/config.yml'
vim.o.cursorline = true
vim.o.backspace = "indent,eol,start"

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.scrolloff = 8
vim.o.signcolumn = 'yes'
vim.o.colorcolumn = "80"

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = 'a'

-- netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 42_header
vim.g.user42 = 'kgriset'
vim.g.mail42 = 'kgriset@student.42.fr'

-- windows
vim.opt.splitright = true
vim.opt.splitbelow = true

