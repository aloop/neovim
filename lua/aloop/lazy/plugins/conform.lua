local prettier = { "prettierd", "prettier", stop_after_first = true }
local shell = { "shfmt" }

local biomeArgs = {
  append_args = {
    "--use-editorconfig=true",
    "--indent-style=space",
    "--line-width=120",
  },
}

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters = {
      biome = biomeArgs,
      ["biome-check"] = biomeArgs,
      php_cs_fixer = {
        append_args = {
          "--rules=@PSR12,@Symfony",
          "--quiet",
          "--no-interaction",
        },
      },
    },
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

      javascript = { "biome-check" },
      javascriptreact = { "biome-check" },
      typescript = { "biome-check" },
      typescriptreact = { "biome-check" },
      json = { "biome-check" },
      jsonc = { "biome-check" },
      html = { "biome-check" },
      css = { "biome-check" },
      scss = prettier,
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = { timeout_ms = 500 },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
