{ pkgs, inputs, config, ... }:
{
programs.neovim = {
  enable   = true;
  vimAlias = true;
};

environment.systemPackages = with pkgs; [
    vimPlugins.vim-plug
];

}
