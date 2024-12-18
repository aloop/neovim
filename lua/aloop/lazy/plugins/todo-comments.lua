return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VimEnter",
  opts = {
    signs = false,
  },
  init = function()
    vim.keymap.set("n", "<leader>tc", function()
      require("todo-comments.fzf").todo()
    end, { desc = "View [t]odo [c]omments" })
  end,
}
