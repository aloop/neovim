{
  description = "My Neovim configuration";

  outputs =
    { self }:
    {
      homeManagerModules = rec {
        neovim = default;
        default =
          {
            lib,
            config,
            pkgs,
            ...
          }:

          let
            inherit (config.lib.file) mkOutOfStoreSymlink;
            inherit (lib) types mkOption mkIf;

            homeDir = config.home.homeDirectory;
            cfg = config.aml.programs.neovim;
          in
          {
            options.aml.programs.neovim = {
              enable = mkOption {
                type = types.bool;
                default = true;
                description = "Whether or not to enable the custom neovim config.";
              };

              shellAliases = mkOption {
                type = types.bool;
                default = true;
                description = "Setup shell aliases for vi/vim/vimdiff";
              };

              config = {
                readOnly = mkOption {
                  type = types.bool;
                  default = true;
                };

                symlinkBase = mkOption {
                  type = types.path;
                  default = "${homeDir}/code/personal/neovim";
                  description = "";
                };
              };
            };

            config = mkIf cfg.enable {
              xdg.configFile =
                if cfg.config.readOnly then
                  {
                    "nvim/lua" = {
                      source = ./lua;
                      recursive = true;
                    };
                    "nvim/lazy-lock.json" = {
                      source = ./lazy-lock.json;
                    };
                  }
                else
                  {
                    "nvim/lua" = {
                      source = mkOutOfStoreSymlink "${cfg.config.symlinkBase}/lua";
                      recursive = true;
                    };
                    "nvim/lazy-lock.json" = {
                      source = mkOutOfStoreSymlink "${cfg.config.symlinkBase}/lazy-lock.json";
                    };
                  };

              xdg.dataFile = {
                "nvim/lazy/telescope-fzf-native.nvim/build/libfzf.so".source = "${pkgs.vimPlugins.telescope-fzf-native-nvim}/build/libfzf.so";
              };

              home.sessionVariables = {
                NIX_NEOVIM = 1;
              };

              programs.neovim = {
                enable = true;
                withPython3 = true;
                withNodeJs = true;

                viAlias = cfg.shellAliases;
                vimAlias = cfg.shellAliases;
                vimdiffAlias = cfg.shellAliases;

                plugins = with pkgs.vimPlugins; [
                  luasnip
                  nvim-treesitter.withAllGrammars
                ];

                extraLuaConfig = lib.readFile ./init.lua;

                extraPackages = with pkgs; [
                  tree-sitter
                  gcc
                  gnumake
                  git
                  ripgrep
                  fd
                  fzf
                  jq
                  lua5_1
                  lua51Packages.luarocks
                  lua-language-server
                  gopls
                  golangci-lint-langserver
                  gofumpt
                  golines
                  goimports-reviser
                  templ
                  gleam
                  stylua
                  vscode-langservers-extracted
                  bash-language-server
                  typescript
                  typescript-language-server
                  tailwindcss-language-server
                  astro-language-server
                  svelte-language-server
                  prettierd
                  nodePackages.prettier
                  htmx-lsp
                  yaml-language-server
                  marksman
                  phpactor
                  isort
                  ruff
                  shellcheck
                  shfmt
                  dockerfile-language-server-nodejs
                  elixir-ls
                  nixd
                  nixfmt-rfc-style
                ];
              };
            };
          };
      };
    };
}
