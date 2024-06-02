return {
  "rcarriga/nvim-notify",
  opts = {
    fps = 120,
    background_colour = "#1e1e2e",
  },
  init = function()
    vim.notify = require("notify")
  end,
}
