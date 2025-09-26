{ config, inputs, pkgs, system, ... }:

{

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ./../../desk-env/hyprland.nix
    ./../../apps/code/pkgmng.nix
    ./../../apps/artist.nix
    ./../../apps/steam.nix
    ./../../apps/tools.nix
    ./../../apps/vim.nix
    ./../../apps/nvim/default.nix
  ];

  boot.loader.systemd-boot.extraEntries = {
    "Arch.conf" = ''
      title   Arch
      linux   /vmlinuz-linux
      initrd  /initramfs-linux.img
      options root=UUID=88963925-30db-4cde-ae91-f62a817fa407 rootfstype=ext4 add_efi_memmap rw
      '';
  };

  # Install firefox
  programs.firefox = {
    enable = true;
  };

  # Android emulator
  virtualisation.waydroid.enable = true;
  services.onlyoffice.enable = true;

  users.users.lukita = {
    isNormalUser = true;
    description = "Lukita";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "1212";
    packages = with pkgs; [
      home-manager
      gparted
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      lukita = import ./home.nix;
    };
  };

  services.mysql = {
  	enable = true;
	package = pkgs.mysql84;
  };

}
