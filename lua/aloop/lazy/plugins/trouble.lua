return {
  "folke/trouble.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  cmd = "Trouble",
  keys = {
    {
      "<leader>xc",
      function()
        local trouble = require("trouble")
        local view = trouble.close()
        while view do
          view = trouble.close()
        end
      end,
      desc = "Close Trouble",
    },
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Current Buffer Diagnostics (Trouble)" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },

    -- { "gd", "<cmd>Trouble lsp_definitions toggle focus=true<cr>", desc = "LSP definitions list" },
    -- { "gD", "<cmd>Trouble lsp_declarations toggle focus=true<cr>", desc = "LSP declarations list" },
    -- { "grr", "<cmd>Trouble lsp_references toggle focus=true<cr>", desc = "LSP references list" },
    -- { "gri", "<cmd>Trouble lsp_implementations toggle focus=true<cr>", desc = "LSP implementations list" },
    -- { "grt", "<cmd>Trouble lsp_type_definitions toggle focus=true<cr>", desc = "LSP type definitions list" },

    { "[x", "<cmd>Trouble prev skip_groups=true jump=true<cr>", desc = "Previous item in Trouble list" },
    { "]x", "<cmd>Trouble next skip_groups=true jump=true<cr>", desc = "Next item in Trouble list" },
  },
  opts = {
    warn_no_results = false,
    auto_close = true,
    auto_jump = true,
  },
}
