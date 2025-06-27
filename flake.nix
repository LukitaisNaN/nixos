{
  description = "A flake that I share with my family =)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        lukitaOs = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            ./users/luki/luki.nix
            ./artist.nix
            ./configuration.nix
            ./hardware-configuration.nix
            ./desk-env/hyprland.nix
            ./steam.nix
            ./tools.nix
            ./vim.nix
          ];
        };

        andreOs = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            ./users/andre/andre.nix
            ./configuration.nix
            ./desk-env/cinnamon.nix
            ./hardware-configuration.nix
            # ./steam.nix
            ./vim.nix
          ];
        };
      };
    };
}
