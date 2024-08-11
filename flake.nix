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

              home.sessionVariables = {
                NIX_NEOVIM = 1;
              };

              programs.neovim = {
                enable = true;
                withPython3 = true;
                withNodeJs = true;

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
