# Neovim configuration

## Installation (generic linux)

```bash
# Backup any existing settings if desired (optional)
mv ~/.config/nvim ~/.config/nvim.bak

# You may also want to remove any existing state/data from an existing configuration (optional)
rm -rf ~/.{cache,local/{state,share}}/nvim

# Clone this repo to ~/.config.nvim
git clone https://github.com/aloop/neovim.git ~/.config/nvim
```

## Installation (NixOS Flake)

In your flake, add this repo as an input:

```nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  aloop-neovim.url = "github:aloop/neovim";
};
```

and include in your desired output:

```nix
outputs = { nixpkgs, home-manager, aloop-neovim, ... }: {
  # NixOS with home-manager
  nixosConfigurations = {
    "yourSystem" = {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.sharedModules = [
            aloop-neovim.homeManagerModules.neovim
          ];
        }
      ];
    };
  };

  # Standalone home-manager
  homeConfigurations =
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      "yourUsername" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          aloop-neovim.homeManagerModules.neovim
        ];
      };
    };
};
```

## Configuration (Nix Flake)

Custom configuration for this flake is available under `aml.programs.neovim`.

Currently there are the following options:

- `aml.programs.neovim.enable` Defaults to `true`
- `aml.programs.neovim.shellAliases` Creates aliases in various shells for mapping neovim to vi/vim/vimdiff
- `aml.programs.neovim.config.readOnly` Determines whether or not you would like the `./lua` directory and `./lazy-lock.json` file to be linked read-only in the nix store.
  When false, this will still link to the `./lua` and `./lazy-lock.json` using home-manager's `mkOutOfStoreSymlink`. Defaults to true
- `aml.programs.neovim.config.symlinkBase` The base directory to use to link `./lua` and `./lazy-lock.json` when `aml.programs.neovim.config.readOnly` is false