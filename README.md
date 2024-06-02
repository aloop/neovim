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

Currently there are only two options:

- `aml.programs.neovim.enable` which defaults to `true`
- `aml.programs.neovim.config.link` which determines whether or not you would like the `./lua` directory to be automatically linked. Defaults to the value of `aml.programs.neovim.enable`