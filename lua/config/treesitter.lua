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
          ["ia"] = "@parameter.inner",
        },
      },

      swap = {
        enable = true,
        swap_previous = {
          ["{a"] = "@parameter.inner",
        },
        swap_next = {
          ["}a"] = "@parameter.inner",
        },
      },

      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]a"] = "@parameter.inner",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[a"] = "@parameter.inner",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
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
