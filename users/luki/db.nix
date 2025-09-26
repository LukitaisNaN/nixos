{ config, pkgs, ... }:
{

  home.packages = with pkgs; [
    dbeaver-bin   # DB manager
  ];
}
