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

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil and client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})
vim.api.nvim_create_autocmd("LspDetach", { command = "setl foldexpr<" })
