local M = {}

local icons = require "config.icons"
local lualine = require "lualine"

function M.setup()
  lualine.setup({
    options = {
      icons_enabled = true,
      theme = "solarized_dark",
    },
  })
end

return M
