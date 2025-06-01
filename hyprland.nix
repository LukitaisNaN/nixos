{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    brightnessctl
    dunst
    grim
    hyprprop
    hyprshot
    nwg-look
    playerctl # key ctrls
    slurp
    waybar
    wl-clipboard
    wofi

 ];
}
