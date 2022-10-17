require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.proselint,
    null_ls.builtins.completion.luasnip,
    -- null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.chktex,
    null_ls.builtins.diagnostics.commitlint,
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.formatting.stylua,
  },
})

require("mason-null-ls").setup({
  ensure_installed = { "proselint", "black", "flake8", "isrot", "mypy", "pylint" },
})
