{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    brigthnessctl playerctl # key ctrls
    hyprshot
    wl-copy
    grim slurp
  ];

}
