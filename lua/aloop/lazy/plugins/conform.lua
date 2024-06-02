return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      go = { "goimports-reviser", "gofumpt", "golines" },
      javascript = { { "prettierd", "prettier" } },
      lua = { "stylua" },
      nix = { "nixfmt" },
      python = { "isort", "ruff" },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
    formatters = {},
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
