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
            inherit (lib)
              types
              mkOption
              mkDefault
              mkIf
              optionals
              optionalString
              concatStrings
              concatStringsSep
              concatLists
              ;

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

              minimal = mkOption {
                type = types.bool;
                default = true;
                description = "Install fewer LSPs/Formatters by default";
              };

              extraPackages = mkOption {
                type = types.listOf types.package;
                default = [ ];
              };

              config = {
                readOnly = mkOption {
                  type = types.bool;
                  default = true;
                };

                installLazyPlugins = mkOption {
                  type = types.bool;
                  default = cfg.config.readOnly;
                };

                symlinkBase = mkOption {
                  type = types.path;
                  default = "${homeDir}/code/personal/neovim";
                  description = "";
                };
              };

              theme = {
                variant = mkOption {
                  type = types.enum [
                    "latte"
                    "frappe"
                    "macchiato"
                    "mocha"
                  ];
                  default = config.aml.theme.variant or "macchiato";
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

              home.sessionVariables = {
                NIXD_FLAGS = mkDefault "-log=error";
              };

              home.extraActivationPath = mkIf (cfg.config.installLazyPlugins) (
                with pkgs;
                [
                  git
                  gnumake
                  gcc
                  config.programs.neovim.finalPackage
                ]
              );

              # Install Lazy.nvim plugins (using restore mode)
              #
              # We copy the lazy-lock.json file here because lazy.nvim doesn't handle
              # a read-only lazy-lock.json without throwing errors.
              #
              # adapted from an example @ https://github.com/LitRidl/EdenVim
              #
              home.activation.installLazyPlugins = mkIf (cfg.config.installLazyPlugins) (
                lib.hm.dag.entryAfter [ "writeBoundary" ] (concatStrings [
                  ''
                    args=""
                    if [[ -z "''${VERBOSE+x}" ]]; then
                      args="--quiet"
                    fi
                    run mkdir -p ~/.config/nvim
                  ''
                  (optionalString (cfg.config.readOnly) ''
                    run rm -f ~/.config/nvim/lazy-lock.json
                    run cp ${./lazy-lock.json} ~/.config/nvim/lazy-lock.json
                    run chmod u+rw ~/.config/nvim/lazy-lock.json
                  '')
                  ''
                    run $args nvim --headless '+Lazy! restore' '+Lazy! clean' +qa
                  ''
                ])
              );

              programs.neovim =
                let
                  treesitterParsersPath = pkgs.symlinkJoin {
                    name = "treesitter-parsers";
                    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
                  };
                in
                {
                  enable = true;
                  withPython3 = true;
                  withNodeJs = true;

                  viAlias = cfg.shellAliases;
                  vimAlias = cfg.shellAliases;
                  vimdiffAlias = cfg.shellAliases;

                  extraLuaConfig = concatStringsSep "\n" [
                    ''
                      vim.g.is_nix = true
                      vim.g.treesitter_parsers_path = "${treesitterParsersPath}"
                      vim.g.nix_catppuccin_variant = "${cfg.theme.variant}"
                      vim.g.nix_sqlite3_path = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}"
                    ''
                    (lib.readFile ./init.lua)
                  ];

                  extraPackages = concatLists [
                    (with pkgs; [
                      # CLI tools
                      tree-sitter
                      gcc
                      gnumake
                      git
                      delta
                      lazygit
                      ripgrep
                      fd
                      fzf
                      jq

                      # Lua
                      lua5_1
                      lua51Packages.luarocks
                      lua-language-server
                      stylua

                      # Shell scripts and text editing
                      marksman
                      bash-language-server
                      yaml-language-server
                      shellcheck
                      shfmt
                      dockerfile-language-server-nodejs

                      # Python
                      isort
                      ruff

                      # Nix
                      nixd
                      nixfmt-rfc-style
                    ])

                    (optionals (!cfg.minimal) (
                      with pkgs;
                      [
                        # Go
                        gopls
                        golangci-lint-langserver
                        gofumpt
                        golines
                        goimports-reviser
                        templ

                        # HTML/CSS/JS/TS
                        vscode-langservers-extracted
                        typescript
                        typescript-language-server
                        tailwindcss-language-server
                        astro-language-server
                        svelte-language-server
                        prettierd
                        nodePackages.prettier
                        biome
                        htmx-lsp

                        # PHP
                        phpactor
                        php.packages.php-codesniffer
                        php.packages.php-cs-fixer
                      ]
                    ))

                    cfg.extraPackages
                  ];
                };
            };
          };
      };
    };
}
