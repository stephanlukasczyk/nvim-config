local cmd = vim.cmd
local fn = vim.fn
local api = vim.api

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Global object
_G.NVMM = {}

local packer_bootstrap = false -- Indicate first time installation

-- packer.nvim configuration
local conf = {
  profile = {
    enable = true,
    threshold = 0,
  },

  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
}

local function packer_init()
  -- Check if packer.nvim is installed
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    cmd([[packadd packer.nvim]])
  end

  -- Run PackerCompile if there are changes in this file
  local packerGrp = api.nvim_create_augroup("packer_user_config", { clear = true })
  api.nvim_create_autocmd(
    { "BufWritePost" },
    { pattern = "init.lua", command = "source <afile> | PackerCompile", group = packerGrp }
  )
end

-- Plugins
local function plugins(use)
  use({ "wbthomason/packer.nvim" })

  -- Solarized colour theme
  use({ "altercation/vim-colors-solarized" })

  -- Nord colour theme
  use({ "arcticicestudio/nord-vim" })

  -- Change colour theme based on iTerm colour-scheme change
  use({
    "will/bgwinch.nvim",
    config = function()
      require("bgwinch").setup()
    end,
  })

  -- Icons
  use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  })

  -- Colorizer to preview colours
  use({
    "nvchad/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
      require("colorizer").setup()
    end,
  })

  -- Startup screen
  use({
    "goolord/alpha-nvim",
    config = function()
      require("config.alpha").setup()
    end,
  })

  -- LuaLine status bar
  use({
    "nvim-lualine/lualine.nvim",
    event = "BufReadPre",
    config = function()
      require("config.lualine").setup()
    end,
    wants = "nvim-web-devicons",
  })

  -- Git
  use({
    "tpope/vim-fugitive",
    opt = true,
    requires = {
      "tpope/vim-rhubarb",
      "idanarye/vim-merginal",
    },
  })
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns")
    end,
  })
  use({ "rhysd/committia.vim" })

  use({ "nvim-lua/plenary.nvim" })

  use({
    "junegunn/goyo.vim",
    config = function()
      require("config.goyo")
    end,
  })

  -- Buffer line
  use({
    "akinsho/nvim-bufferline.lua",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require("config.bufferline").setup()
    end,
  })

  -- LuaSnip
  use({
    "L3MON4D3/LuaSnip",
    config = function()
      require("config.luasnip").setup()
    end,
    requires = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
  })

  -- Autocompletion
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("config.nvim-cmp").setup()
    end,
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
    },
  })

  -- Indent Blankline
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("config.blankline").setup()
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("config.treesitter").setup()
    end,
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  })

  -- LSP
  use({
    "williamboman/mason.nvim",
    config = function()
      require("config.lsp").setup()
    end,
    requires = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "j-hui/fidget.nvim",
    },
  })

  use({
    "f3fora/nvim-texlabconfig",
    config = function()
      require("config.texlab").setup()
    end,
    requires = {
      "neovim/nvim-lspconfig",
    },
    ft = { "tex", "bib", "dtx", "ins" },
    run = "go build -o ~/bin/",
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.telescope").setup()
    end,
    requires = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  })
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  })

  -- Markdown
  use({
    "iamcco/markdown-preview.nvim",
    opt = true,
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
    requires = {
      "zhaozg/vim-diagram",
      "aklt/plantuml-syntax",
    },
  })

  -- Bootstrap NeoVIM
  if packer_bootstrap then
    print("NeoVIM restart is required after installation!")
    require("packer").sync()
  end
end

-- packer.nvim
packer_init()
local packer = require("packer")
packer.init(conf)
packer.startup(plugins)

require("config.nord")
require("config.general")
require("config.filetypes")
