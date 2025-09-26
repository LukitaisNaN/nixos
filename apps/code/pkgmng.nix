{ inputs, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs_24
    cargo
  ];
}

# To make npm work use:
# npm config set prefix "${HOME}/.cache/npm/global"
# mkdir -p "${HOME}/.cache/npm/global"
