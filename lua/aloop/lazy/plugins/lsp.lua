local nix_conf_path = string.format("%s/nixos-config", vim.fn.expand("~"))
local nix_conf_exists = vim.fn.isdirectory(nix_conf_path) == 1
local flake_host = "HomeServer"

local globalCapabilities = {
  capabilities = {
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
  },
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true, cond = not vim.g.is_nix }, -- NOTE: Must be loaded before dependants
    { "williamboman/mason-lspconfig.nvim", cond = not vim.g.is_nix },
    { "saghen/blink.cmp" },
  },
  opts = {
    servers = {
      bashls = {},
      dockerls = {},
      docker_compose_language_service = {},
      jsonls = {},
      yamlls = {
        redhat = {
          telemetry = {
            enabled = false,
          },
        },
        yaml = {
          format = {
            enable = false, -- use prettier instead
          },
          completion = true,
          hover = true,
          validate = true,
          schemas = {
            ["kubernetes"] = { "k8s/**/*.yml", "k8s/**/*.yaml" },
          },
        },
      },
      marksman = {},
      astro = {},
      html = {},
      templ = {},
      cssls = {},
      biome = {},
      svelte = {},
      tailwindcss = {},
      ruff = {},
      phpactor = {},
      golangci_lint_ls = {},

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
            diagnostic = {
              suppress = {
                "sema-escaping-with",
              },
            },
            options = {
              nixos = {
                expr = nix_conf_exists and string.format('(builtins.getFlake "%s").nixosConfigurations.%s.options', nix_conf_path, flake_host) or nil,
              },
              home_manager = {
                expr = nix_conf_exists and string.format(
                  '(builtins.getFlake "%s").nixosConfigurations.%s.options.home-manager.users.type.getSubOptions []',
                  nix_conf_path,
                  flake_host
                ) or nil,
              },
            },
          },
        },
        on_attach = function() vim.lsp.inlay_hint.enable(true, { bufnr = 0 }) end,
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
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = "Replace",
            },
            doc = {
              privateName = { "^_" },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("aloop-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc) vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc }) end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup("aloop-lsp-highlight", { clear = false })
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
            group = vim.api.nvim_create_augroup("aloop-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "aloop-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        -- Add mapping to toggle inlay hints
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map("<leader>th", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })) end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          [vim.diagnostic.severity.WARN] = "WarningMsg",
          [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
          [vim.diagnostic.severity.HINT] = "DiagnosticHint",
        },
      },
      virtual_text = false,
      virtual_lines = {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
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

    for server, config in pairs(opts.servers) do
      local capabilities = vim.tbl_deep_extend("force", {}, globalCapabilities or {}, config.capabilities or {})
      config.capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

      lspconfig[server].setup(config)
    end
  end,
}
