{ pkgs, inputs, config, ... }:
{

  programs.neovim = {
    vimAlias = true;
    enable   = true;
    package  = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

}
