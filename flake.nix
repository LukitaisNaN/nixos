{
  description = "A very lol flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable } : {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {};
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./hyprland.nix
      ];
    };

  };
}
