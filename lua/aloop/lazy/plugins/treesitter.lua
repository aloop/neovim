return {
  "nvim-treesitter/nvim-treesitter",
  enabled = not vim.g.is_nix,
  build = ":TSUpdate",
  opts = {
    ensure_installed = vim.g.is_nix and {} or { "c", "lua", "vim", "vimdoc", "query" },
    auto_install = not vim.g.is_nix,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.configs").setup(opts)
  end,
}
