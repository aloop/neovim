return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      background = {
        dark = "macchiato",
      },
      transparent_background = true,
      term_colors = true,
      styles = {
        functions = { "bold" },
        keywords = { "bold" },
      },
      integrations = {
        telescope = {
          enabled = true,
        },
        native_lsp = {
          enabled = true,
        },
        illuminate = {
          enabled = true,
        },
        mini = {
          enabled = true,
        },
        treesitter = true,
        cmp = true,
        blink_cmp = true,
        lsp_trouble = true,
        gitsigns = true,
        neogit = true,
        diffview = true,
        noice = true,
        which_key = true,
        mason = true,
        markdown = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
