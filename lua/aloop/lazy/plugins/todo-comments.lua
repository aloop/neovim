return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VimEnter',
  opts = {
    signs = false,
  },
  init = function()
    vim.keymap.set('n', '<leader>tc', '<cmd>TodoTelescope<cr>', { desc = 'View todo comments in Telescope' })
  end,
}
