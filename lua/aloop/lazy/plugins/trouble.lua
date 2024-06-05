return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    { "gd", "<cmd>Trouble lsp_definitions toggle focus=true<cr>", desc = "LSP definitions list" },
    { "gD", "<cmd>Trouble lsp_declarations toggle focus=true<cr>", desc = "LSP definitions list" },
    { "gr", "<cmd>Trouble lsp_references toggle focus=true<cr>", desc = "LSP references list" },
    { "gi", "<cmd>Trouble lsp_implementations toggle focus=true<cr>", desc = "LSP implementations list" },
    { "gt", "<cmd>Trouble lsp_type_definitions toggle focus=true<cr>", desc = "LSP type definitions list" },
  },
  opts = {},
}
