local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local nix_conf_path = string.format("%s/nixos-config", vim.fn.expand("~"))
local nix_conf_exists = vim.fn.isdirectory(nix_conf_path) == 1

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true, enabled = not vim.g.is_nix }, -- NOTE: Must be loaded before dependants
    { "williamboman/mason-lspconfig.nvim", enabled = not vim.g.is_nix },
    { "saghen/blink.cmp" },
  },
  opts = {
    servers = {
      bashls = {},
      dockerls = {},
      jsonls = {},
      yamlls = {},
      marksman = {},
      astro = {},
      html = {},
      templ = {},
      cssls = {},
      svelte = {},
      tailwindcss = {},
      ruff = {},
      phpactor = {},
      golangci_lint_ls = {},
      gleam = {},

      -- nil_ls = {
      --   settings = {
      --     ["nil"] = {
      --       formatting = {
      --         command = { "nixfmt" },
      --       },
      --     },
      --   },
      --   on_attach = function()
      --     vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
      --   end,
      -- },

      nixd = {
        settings = {
          nixd = {
            nixpkgs = {
              expr = "import <nixpkgs> { }",
            },
            formatting = {
              command = { "nixfmt" },
            },
            options = {
              nixos = {
                expr = nix_conf_exists and string.format('(builtins.getFlake "%s").nixosConfigurations.HomeServer.options', nix_conf_path) or nil,
              },
              home_manager = {
                expr = nix_conf_exists
                    and string.format('(builtins.getFlake "%s").nixosConfigurations.HomeServer.options.home-manager.users.type.getSubOptions []', nix_conf_path)
                  or nil,
              },
            },
          },
        },
        on_attach = function()
          vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
        end,
      },

      gopls = {
        settings = {
          gopls = {
            staticcheck = true,
            semanticTokens = true,
            ["ui.completion.usePlaceholders"] = true,
            ["ui.diagnostic.analyses"] = {
              fieldalignment = true,
              shadow = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
              unusedvariable = true,
            },
            ["ui.inlayhint.hints"] = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = false,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      },

      ts_ls = {
        settings = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
      },

      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        -- map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    if not vim.g.is_nix then
      require("mason").setup()

      local ensure_installed = vim.tbl_keys(opts.servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
      })

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
    end

    local lspconfig = require("lspconfig")
    local blink = require("blink.cmp")

    for server, config in pairs(opts.servers) do
      config.capabilities = blink.get_lsp_capabilities(config.capabilities)
      config.handlers = handlers

      lspconfig[server].setup(config)
    end
  end,
}
