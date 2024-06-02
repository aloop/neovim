return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    cmd = { "ToggleTerm" },
    opts = {
      open_mapping = [[<c-t>]],
    },
    keys = {
      { "<c-t>", "<cmd>ToggleTerm<cr>", desc = "Terminal" },
    },
    init = function()
      vim.api.nvim_create_autocmd("TermOpen", {
        desc = "Automatically resize splits when the window size changes",
        group = vim.api.nvim_create_augroup("toggleterm_keymaps", { clear = true }),
        pattern = "term://*toggleterm#*",
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
          vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
        end,
      })
    end,
  },
}
