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
            ./users/andre/andre.nix
            ./artist.nix
            ./configuration.nix
            ./desk-env/hyprland.nix
            ./apps/steam.nix
            ./apps/tools.nix
            ./apps/vim.nix
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
            ./apps/vim.nix
          ];
        };
      };
    };
}
