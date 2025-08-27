{ config, inputs, pkgs, system, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    #./hardware-configuration.nix
  ];

  # Install firefox
  programs.firefox = {
    enable = true;
  };

  services.onlyoffice.enable = true;

  users.users.ebo = {
    isNormalUser = true;
    description = "ebo";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "1212";
    packages = with pkgs; [
      home-manager
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      ebo = import ./home.nix;
    };
  };
  
}
