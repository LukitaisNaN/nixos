{ config, inputs, pkgs, system, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.andreita = {
    isNormalUser = true;
    description = "chuchu";
    initialPassword = "1212";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      home-manager
    ];
  };

  # Brave configuration
  programs.chromium = {
    enable = true;
    homepageLocation = "google.com";
    extensions = [ "cjpalhdlnbpafiamejdnhcphjbkeiagm" ]; # ublock origin
    extraOpts = {
      "DefaultSearchProviderNewTabURL" = "google.com";
    };
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
