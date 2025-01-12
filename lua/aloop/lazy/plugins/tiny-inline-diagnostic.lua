return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  opts = {
    preset = "modern",
    options = {
      multilines = {
        enabled = true,
      },
    },
  },
  init = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
}
