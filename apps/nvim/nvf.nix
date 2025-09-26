
{ pkgs, inputs, config, ... }:
{
  # Weird neovim, maybe someday I will use it.
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
        };

        additionalRuntimePaths = [ "$HOME/.config/nvim-extra" ];
        package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
        lsp.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        languages = {
          enableTreesitter = true;
          enableFormat = true;

          nix.enable = true;
          clang.enable = true;
          ts.enable = true;
        };
      };
    };
  };

}

