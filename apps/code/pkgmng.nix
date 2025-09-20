{ inputs, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs_24
    cargo
  ];
}
