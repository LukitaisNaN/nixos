{ pkgs, services, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  environment.systemPackages = with pkgs; [

    kdePackages.dolphin     # File explorer
    brightnessctl           # Self-explanatory
    dunst                   # Notification manager
    grim slurp              # hyprshot dependancies
    hyprcursor              # Cursors
    hyprpaper               # Wallpaper
    hyprprop                # See which properties a window has
    hyprpolkitagent         # Popup that appears when an app wants elevated permissions
    hyprshot                # Screenshots
    nwg-look                # GTK-settings editor
    playerctl               # For video ctrls
    waybar                  # Wayland bar
    wl-clipboard            # Copy/paste utilities
    wofi                    # Application launcher
  ];

  services.greetd.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # xdg-portal for gtk aplications and screen-sharing
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

}
