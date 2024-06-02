return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- Lazy-loading seems to break the `default_file_explorer` functionality
  lazy = false,
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open directory of current buffer in Oil" },
  },
  opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,

    columns = { "icon" },

    view_options = {
      show_hidden = true,
    },

    win_options = {
      winbar = "%{v:lua.require('oil').get_current_dir()}",
    },
  },
}
