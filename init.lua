vim.g.is_nix = os.getenv("NIX_NEOVIM") == "1"
if os.getenv("NIX_NEOVIM_TREESITTER_PARSERS_PATH") ~= nil then
  vim.opt.runtimepath:append(os.getenv("NIX_NEOVIM_TREESITTER_PARSERS_PATH"))
end

require("aloop")
