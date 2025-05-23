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

if vim.g.is_nix then
  default_parsers = {}
end

return {
  (not vim.g.is_nix and "nvim-treesitter/nvim-treesitter") or nil,
  dir = (vim.g.is_nix and vim.g.treesitter_plugin_path) or nil,
  name = "nvim-treesitter",
  build = (not vim.g.is_nix and ":TSUpdate") or nil,
  pin = vim.g.is_nix,
  opts_extend = {},
  opts = {
    ensure_installed = default_parsers,
    sync_install = false,
    auto_install = not vim.g.is_nix,
    highlight = {
      enable = true,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,

      keymaps = {
        init_selection = "<Enter>",
        node_incremental = "<Enter>",
        scope_incremental = false,
        node_decremental = "<Backspace>",
      },
    },
  },
  init = function()
    if vim.g.treesitter_parsers_path ~= nil then
      vim.opt.rtp:prepend(vim.g.treesitter_parsers_path)
    end
  end,
  config = function(_, opts)
    require("nvim-treesitter.install").prefer_git = true
    require("nvim-treesitter.configs").setup(opts)
  end,
}
