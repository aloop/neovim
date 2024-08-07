local default_parsers = {
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "json",
  "yaml",
  "nix",
  "go",
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "hiphish/rainbow-delimiters.nvim",
  },
  opts = {
    ensure_installed = default_parsers,
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    additional_vim_regex_highlighting = false,
  },
  config = function(_, opts)
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.configs").setup(opts)
  end,
}
