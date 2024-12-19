return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  keys = {
    { "-", "<cmd>Oil --float<cr>", desc = "Open directory of current buffer in Oil" },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,

    columns = { "icon" },

    view_options = {
      show_hidden = true,
      natural_order = true,
    },

    win_options = {
      winbar = "%{v:lua.require('oil').get_current_dir()}",
    },

    float = {
      padding = 2,
      max_width = 90,
      max_height = 0,
    },

    keymaps = {
      ["q"] = "actions.close",
    },
  },
}
