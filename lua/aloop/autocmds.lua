vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = vim.api.nvim_create_augroup("my-highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank({ timeout = 250 }) end,
})

vim.api.nvim_create_autocmd("VimResized", {
  desc = "Automatically resize splits when the window size changes",
  group = vim.api.nvim_create_augroup("my-window-resize", { clear = true }),
  pattern = "*",
  command = "wincmd =",
})
