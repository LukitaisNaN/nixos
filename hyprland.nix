{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    brightnessctl
    dunst             # Notification manager
    grim              # hyprshot dependancy
    hyprprop          # See which properties a window has 
    hyprpolkitagent   # Popup that appears when an app wants elevated permissions
    hyprshot          # Screenshots
    nwg-look          # GTK-settings editor
    playerctl         # For video ctrls
    slurp             # hyprshot dependancy
    waybar            # Wayland bar
    wl-clipboard      # Copy/paste utilities
    wofi              # Application launcher

 ];
}
