if vim.g.nix_catppuccin_variant == nil then
  vim.g.nix_catppuccin_variant = "macchiato"
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = vim.g.nix_catppuccin_variant,
      background = {
        dark = vim.g.nix_catppuccin_variant,
      },
      transparent_background = true,
      term_colors = true,
      styles = {
        functions = { "bold" },
        keywords = { "bold" },
      },
      integrations = {
        native_lsp = {
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
      custom_highlights = function(colors)
        return {
          MiniStatuslineMacro = { bg = colors.red, fg = colors.base, style = { "bold" } },
        }
      end,
    },
    init = function() vim.cmd.colorscheme("catppuccin") end,
  },
}
