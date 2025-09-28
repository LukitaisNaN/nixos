{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.chuchu= {
    isNormalUser = true;
    description = "Andreita";
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

  services.onlyoffice.enable = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      chuchu = import ./home.nix;
    };
  };

}
