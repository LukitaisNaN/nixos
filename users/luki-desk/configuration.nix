{ inputs, config, pkgs, ... }:

{

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users = {
      luki-desk = import ./home.nix;
    };
  };

  # Bootloader
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };

    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "home-server"; # Define your hostname.

  users.users.server = {
    isNormalUser = true;
    description = "Server";
    extraGroups = [ "networkmanager" ];
    initialPassword = "1212";
    packages = with pkgs; [
      vim
    ];
  };

  users.users.luki-desk = {
    isNormalUser = true;
    description = "luki-desk";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "1212";
    packages = with pkgs; [
      vim
    ];
  };

  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty               # Terminal emulator
    #libreoffice             # Word, Excel, etc
    localsend               # Send files to other devices in same network
    git                     # Control version
    pavucontrol             # Manage input and output devices
    vlc                     # Video/Audio player
    wget
    unzip
  ];

  environment.variables = {
    EDITOR    = "vim";
    SHELL     = "bash";
    TERM      = "alacritty";
    TERMINAL  = "alacritty";
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.hurmit
    noto-fonts-color-emoji
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable networkmanager
  networking.networkmanager.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Argentina/Cordoba";

  # System language.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT    = "es_AR.UTF-8";
    LC_MONETARY       = "es_AR.UTF-8";
    LC_NAME           = "es_AR.UTF-8";
    LC_NUMERIC        = "es_AR.UTF-8";
    LC_PAPER          = "es_AR.UTF-8";
    LC_TELEPHONE      = "es_AR.UTF-8";
    LC_TIME           = "es_AR.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable Flakes and Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable       = true;
  hardware.bluetooth.powerOnBoot  = true;
  services.blueman.enable         = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Accelerated video playback (idk what it is, but sounds useful)
  hardware.graphics = {
    enable = true;
  };

  system.stateVersion = "24.11"; # Did you read the comment?

}
