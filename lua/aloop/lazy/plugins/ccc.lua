return {
  "uga-rosa/ccc.nvim",
  name = "ccc",
  event = "FileType",
  cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
  opts = {
    lsp = false, -- Seems to crash nixd when this is enabled
    highlighter = {
      auto_enable = true,
    },
  },
  keys = {
    { "<Leader>hlt", "<cmd>CccHighlighterToggle<CR>", desc = "Toggle Color Highlighting" },
    { "<Leader>cp", "<cmd>CccPick<CR>", desc = "Color Picker" },
    { "<Leader>cc", "<cmd>CccConvert<CR>", desc = "Convert Color (hex/rgb/hsl)" },
  },
}
