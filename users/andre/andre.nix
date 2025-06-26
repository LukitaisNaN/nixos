{ config, inputs, pkgs, system, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.andre = {
    isNormalUser = true;
    description = "Andreita";
    initialPassword = "1212"
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      brave
      home-manager
    ];
  };

  # Brave configuration
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
    ];
    commandLineArgs = [
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
    ];
  }

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      andreita = import ./home.nix;
    };
  };

  # System language.
  i18n.defaultLocale = "es_AR.UTF-8";


}
