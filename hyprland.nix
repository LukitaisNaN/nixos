{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl # key ctrls
    hyprshot
    wl-clipboard
    grim slurp
 ];

}
