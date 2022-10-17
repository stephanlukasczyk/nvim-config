local M = {}

function M.setup()
  local texlab = require "texlabconfig"
  local config = {
    cache_filetypes = { "tex", "bib", "ins", "dtx" }
  }

  texlab.setup(config)
end

return M
