{ pkgs, ... }:

{

  services.greetd.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl     # Self-explanatory
    dunst             # Notification manager
    grim slurp        # hyprshot dependancies
    hyprcursor        # cursors
    hyprprop          # See which properties a window has 
    hyprpolkitagent   # Popup that appears when an app wants elevated permissions
    hyprshot          # Screenshots
    nwg-look          # GTK-settings editor
    playerctl         # For video ctrls
    waybar            # Wayland bar
    wl-clipboard      # Copy/paste utilities
    wofi              # Application launcher
 ];
}
