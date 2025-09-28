{
  description = "A flake that I share with my family =)";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # nvf.url = "github:notashelf/nvf";

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
            #./users/andre/andre.nix
            ./configuration.nix
            #nvf.nixosModules.default
          ];
        };

        andreOs = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            ./users/andre/andre.nix
            ./configuration.nix
            #./users/andre/hardware-configuraion.nix
            ./desk-env/cinnamon.nix
            ./apps/steam.nix
          ];
        };

        eborito = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            ./users/ebo/ebo.nix
            ./configuration.nix
            ./desk-env/deepin.nix
          ];
        };

        luki-desk = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
          ./users/luki-desk/configuration.nix
	  ./desk-env/hyprland.nix
          ./apps/nvim/default.nix
          ];
        };

      };
    };
}
