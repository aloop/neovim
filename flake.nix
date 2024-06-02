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
            inherit (lib) types mkOption mkIf;

            cfg = config.aml.programs.neovim;
          in
          {
            options.aml.programs.neovim = {
              enable = mkOption {
                type = types.bool;
                default = true;
                description = "Whether or not to enable the custom neovim config.";
              };

              config.link = mkOption {
                type = types.bool;
                default = cfg.enable;
                description = "Disable if you would like to manually manage the ~/.config/nvim/lua link";
              };
            };

            config = mkIf cfg.enable {
              # Link lua directory from my NeoVim config to ~/.config/nvim/lua
              xdg.configFile = mkIf cfg.config.link {
                "nvim/lua" = {
                  source = ./lua;
                  recursive = true;
                };
              };

              xdg.dataFile = {
                "nvim/lazy/telescope-fzf-native.nvim/build/libfzf.so".source = "${pkgs.vimPlugins.telescope-fzf-native-nvim}/build/libfzf.so";
              };

              programs.neovim =
                let
                  treesitter-parsers = pkgs.symlinkJoin {
                    name = "treesitter-parsers";
                    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
                  };
                in
                {
                  enable = true;
                  withPython3 = true;
                  withNodeJs = true;

                  plugins = with pkgs.vimPlugins; [
                    {
                      plugin = nvim-treesitter.withAllGrammars;
                      type = "lua";
                      config = # lua
                        ''
                          vim.opt.runtimepath:append('${nvim-treesitter.withAllGrammars}')
                          vim.opt.runtimepath:append('${treesitter-parsers}')
                          require('nvim-treesitter.configs').setup(require('aloop.lazy.plugins.treesitter').opts)
                        '';
                    }
                    luasnip
                  ];

                  extraLuaConfig = # lua
                    ''
                      -- Indicate that the nvim config is being run under a Nix/NixOS env
                      vim.g.is_nix = true
                      -- Load my configuration
                      require('aloop')
                    '';

                  extraPackages = with pkgs; [
                    gcc
                    gnumake
                    git
                    ripgrep
                    fd
                    jq
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
                    nodePackages.bash-language-server
                    nodePackages.typescript-language-server
                    nodePackages."@tailwindcss/language-server"
                    nodePackages."@astrojs/language-server"
                    nodePackages.svelte-language-server
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
