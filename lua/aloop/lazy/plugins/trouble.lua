local set = vim.keymap.set

return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>xx', '<cmd>TroubleToggle<cr>', { desc = 'Toggle trouble' } },
    { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { desc = 'Toggle workspace diagnostics' } },
    { '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { desc = 'Toggle document diagnostics' } },
    { '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { desc = 'Toggle quickfixes' } },
    { '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { desc = 'Toggle loclist' } },
    { 'gi', '<cmd>TroubleToggle lsp_implementations<cr>', { desc = 'LSP implementations list' } },
    { 'gd', '<cmd>TroubleToggle lsp_definitions<cr>', { desc = 'LSP definitions list' } },
    { 'gD', '<cmd>TroubleToggle lsp_references<cr>', { desc = 'LSP references list' } },
    { 'gt', '<cmd>TroubleToggle lsp_type_definitions<cr>', { desc = 'LSP references list' } },
  },
}
