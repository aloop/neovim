return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- Diff integration
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    kind = "auto",
  },
  keys = {
    { "<leader>ng", "<cmd>Neogit<cr>", desc = "Open Neogit" },
  },
  config = true,
}
