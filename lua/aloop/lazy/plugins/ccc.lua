return {
  "uga-rosa/ccc.nvim",
  name = "ccc",
  event = "FileType",
  cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
  opts = {
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
