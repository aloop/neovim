return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    globalstatus = true,
    disabledFiletypes = {
      winbar = {
        'help',
        'dashboard',
        'NvimTree',
      },
    },
    theme = 'catppuccin',
  },
}
