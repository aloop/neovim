local prettier = { "prettierd", "prettier", stop_after_first = true }
local shell = { "shfmt" }

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      go = { "goimports-reviser", "gofumpt", "golines" },
      templ = { "templ" },
      lua = { "stylua" },
      nix = { "nixfmt" },
      python = { "isort", "ruff" },
      rust = { "rustfmt", lsp_format = "fallback" },
      php = { "php_cs_fixer" },

      sh = shell,
      bash = shell,

      css = prettier,
      scss = prettier,
      html = prettier,
      json = prettier,
      jsonc = prettier,
      javascript = prettier,
      typescript = prettier,
      vue = prettier,
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = { timeout_ms = 500 },
    formatters = {
      php_cs_fixer = {
        append_args = {
          "--rules=@PSR12,@Symfony",
          "--quiet",
          "--no-interaction",
        },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
