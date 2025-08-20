{inputs, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      vim-full
      alejandra     # Nix code formatter
      deadnix
      nodePackages_latest.cspell # LSP for a lot of languages
      diff-so-fancy # Better git diff
      pyright       # Python lsp
      tree          # Directories tree view
    ];
    
}
