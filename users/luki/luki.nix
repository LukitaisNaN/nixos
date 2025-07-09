{ config, inputs, pkgs, system, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
  ];

  # Install firefox.
  programs.firefox = {
    enable = true;
  };

  users.users.lukita = {
    isNormalUser = true;
    description = "Lukita";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "1212";
    packages = with pkgs; [
      home-manager
      lmms
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      lukita = import ./home.nix;
    };
  };

  
}
