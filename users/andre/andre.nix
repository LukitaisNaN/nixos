{ config, inputs, pkgs, system, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.andreita = {
    isNormalUser = true;
    description = "Andreita";
    initialPassword = "1212";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      brave
      home-manager
    ];
  };

  # Brave configuration
  programs.chromium = {
    enable = true;
    homepageLocation = "google.com";
   # extensions = [
   #   { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
   # ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      andreita = import ./home.nix;
    };
  };

  # System language.
  i18n.defaultLocale = "es_AR.UTF-8";

}
