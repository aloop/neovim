local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = "aloop.lazy.plugins",
  ui = { border = "rounded" },
  change_detection = {
    notify = false,
  },
  performance = {
    reset_packpath = not vim.g.is_nix,
    rtp = {
      reset = not vim.g.is_nix,
    },
  },
})
