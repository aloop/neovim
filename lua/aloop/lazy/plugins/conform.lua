return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      go = { "goimports-reviser", "gofumpt", "golines" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      lua = { "stylua" },
      nix = { "nixfmt" },
      python = { "isort", "ruff" },
      rust = { "rustfmt" },
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = { timeout_ms = 500 },
    formatters = {},
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
