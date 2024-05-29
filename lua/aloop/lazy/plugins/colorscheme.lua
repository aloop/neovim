return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'macchiato',
      background = {
        dark = 'macchiato',
      },
      transparent_background = true,
      term_colors = true,
      styles = {
        functions = { 'bold' },
        keywords = { 'bold' },
      },
    },
    init = function()
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
