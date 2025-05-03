{
  description = "A very lol flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {};
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };

  };
}
