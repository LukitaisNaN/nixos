{ pkgs, ... }:
{

  home.packages = with pkgs; [
    dbeaver-bin   # DB manager
    mongodb
    mongodb-tools
    mongodb-compass
  ];
}
