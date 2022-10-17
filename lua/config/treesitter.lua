local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },

    ensure_installed = {
      "bibtex",
      "css",
      "dockerfile",
      "dot",
      "gitignore",
      "html",
      "java",
      "latex",
      "lua",
      "markdown",
      "python",
      "sql",
      "toml",
      "vim",
    },
  })
end

return M
