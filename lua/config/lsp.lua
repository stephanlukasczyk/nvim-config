local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

function M.setup()
  require("mason").setup({
    ui = { border = "rounded" },
  })

  require("fidget").setup({
    text = {
      spinner = "moon",
    },

    window = {
      blend = 0,
    },

    sources = {
      ["null-ls"] = { ignore = true },
    },
  })

  -- Attach the diagnostic configuration
  M.diagnostics()

  -- Configure the various LSP servers
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lspconfig = require("lspconfig")

  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local bind = vim.keymap.set
    local buf = vim.lsp.buf

    bind("n", "gD", buf.declaration, bufopts)
    bind("n", "gd", buf.definition, bufopts)
    bind("n", "K", buf.hover, bufopts)
    bind("n", "gi", buf.implementation, bufopts)
    bind("n", "<c-k>", buf.signature_help, bufopts)
    bind("n", "<space>wa", buf.add_workspace_folder, bufopts)
    bind("n", "<space>wr", buf.remove_workspace_folder, bufopts)
    bind("n", "<space>wl", function()
      print(vim.inspect(buf.list_workspace_folders()))
    end, bufopts)
    bind("n", "<space>D", buf.type_definition, bufopts)
    bind("n", "<space>rn", buf.rename, bufopts)
    bind("n", "<space>ca", buf.code_action, bufopts)
    bind("n", "gr", buf.references, bufopts)
    bind("n", "<space>f", function()
      buf.format({ async = true })
    end, bufopts)
  end

  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
  }

  M.setup_lsp("pyright", lspconfig, capabilities, on_attach, handlers)
  M.setup_lsp("pylsp", lspconfig, capabilities, on_attach, handlers)
  M.setup_texlab(lspconfig, capabilities, on_attach, handlers)
  -- M.setup_digestif(lspconfig, capabilities, on_attach, handlers)
  M.setup_lua(lspconfig, capabilities, on_attach, handlers)
  M.setup_null_ls(on_attach)

  local icons = {}
  icons.icon = {
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = "了 ",
    EnumMember = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = "ﰮ ",
    Keyword = " ",
    Method = "ƒ ",
    Module = " ",
    Property = " ",
    Snippet = "  ",
    Struct = " ",
    Text = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
  }
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = icons.icon[kind] or kind
  end
end

function M.setup_lsp(name, lspconfig, capabilities, on_attach, handlers)
  lspconfig[name].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  })
end

function M.setup_digestif(lspconfig, capabilities, on_attach, handlers)
  lspconfig["digestif"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
    settings = {
      digestif = {
        command = "digestif",
        filetypes = {"tex", "plaintex", "context"},
      },
    },
  })
end

function M.setup_texlab(lspconfig, capabilities, on_attach, handlers)
  local executable = "/Applications/Skim.app/Contents/SharedSupport/displayline"
  local args = { "%l", "%p", "%f" }

  lspconfig["texlab"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
    settings = {
      texlab = {
        forwardSearch = {
          executable = executable,
          args = args,
        },
      },
    },
  })
end

function M.setup_lua(lspconfig, capabilities, on_attach, handlers)
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  require("cmp").setup.filetype("lua", {
    sources = {
      { name = "path" },
      { name = "nvim_lua" },
      { name = "nvim_lsp", keyword_length = 3 },
      { name = "buffer", keyword_length = 3 },
      { name = "luasnip", keyword_length = 2 },
    },
  })

  lspconfig["lua_ls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = runtime_path,
        },

        diagnostics = {
          globals = { "vim" },
        },

        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.stdpath("config") .. "/lua",
          },
        },
      },
    },
  })
end

function M.setup_null_ls(on_attach)
  local null_ls = require("null-ls")

  local config = {
    on_attach = function(client, bufnr)
      local bufcmd = vim.api.nvim_buf_create_user_command
      local format_cmd = function(input)
        vim.lsp.buf.format({
          id = client.id,
          timeout_ms = 5000,
          async = input.bang,
        })
      end

      bufcmd(bufnr, "NullFormat", format_cmd, {
        bang = true,
        range = true,
        desc = "Format using null-ls",
      })

      vim.keymap.set({ "n", "x" }, "gq", "<cmd>NullFormat<cr>", {
        bufnr = bufnr,
      })
    end,

    on_attach = on_attach,

    sources = {
      null_ls.builtins.code_actions.proselint.with({
        filetypes = { "markdown", "tex", "text", "mail" },
      }),
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.chktex,
      null_ls.builtins.diagnostics.proselint.with({
        filetypes = { "markdown", "tex", "text", "mail" },
      }),
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.write_good,
      null_ls.builtins.formatting.latexindent,
      null_ls.builtins.formatting.stylua,
    },
  }

  null_ls.setup(config)
end

function M.diagnostics()
  local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = "",
    })
  end

  sign({ name = "DiagnosticSignError", text = "✘" })
  sign({ name = "DiagnosticSignWarn", text = "▲" })
  sign({ name = "DiagnosticSignHint", text = "⚑" })
  sign({ name = "DiagnosticSignInfo", text = "»" })

  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  local group = augroup("diagnostic_cmds", { clear = true })

  autocmd("ModeChanged", {
    group = group,
    pattern = { "n:i", "v:s" },
    desc = "Disable diagnostics while typing",
    callback = function()
      vim.diagnostic.disable(0)
    end,
  })

  autocmd("ModeChanged", {
    group = group,
    pattern = "i:n",
    desc = "Enable diagnostics when leaving insert mode",
    callback = function()
      vim.diagnostic.enable(0)
    end,
  })

  local bind = vim.keymap.set
  local opts = { noremap = true, silent = true }
  bind("n", "<leader>do", vim.diagnostic.open_float, opts)
  bind("n", "<leader>d[", vim.diagnostic.goto_prev, opts)
  bind("n", "<leader>d]", vim.diagnostic.goto_next, opts)
  bind("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", opts)
end

return M
