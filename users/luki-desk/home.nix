{ config, pkgs, ... }:

let
  homeDir = config.home.homeDirectory;
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.username = "luki-desk";
  home.homeDirectory = "/home/luki-desk";

  home.packages = with pkgs; [
    lsd

    # Help
    (pkgs.writeShellScriptBin "Help" ''
      cat << EOF
      omg!!! $USER needs help!!! Te dejo por acá los comandos que podés usar, 
      fijate que empiezan con mayúscula.
      "Edit":    Usalo cuando quieras instalar algún programa, te va a abrir un 
                   archivo de configuración.
                 En el archivo está explicado qué hacer.
      "Rebuild": Usalo después de "Edit" para instalar los programas que hayas agregado.
      "Save":    Por si querés guardar en la nube los cambios que hiciste.
      "Update":  Descarga los cambios que haya en la nube. Normalmente
                   te voy a indicar cuando haga falta usar este comando =).
      EOF
      '')

    # Rebuild
    (writeShellScriptBin "Rebuild" ''
      sudo nixos-rebuild switch --flake ~/.config/nixos/#$USER
    '')

    # Push
    (writeShellScriptBin "Save" ''
      touch ~/tmp pwd > ~/tmp
      cd ~/.config/nixos
      git add .
      git commit -m "$USER's automatic backup"
      git rebase
      git push
      cd `cat ~/tmp`
      rm ~/tmp
      echo "Config uploaded :P"
    '')

    # Pull
    (writeShellScriptBin "Update" ''
      cd ~/.config/nixos
      echo "Downloading from github..."
      git merge
      cd 
      echo "Updating..."
      Rebuild
      echo "Update finished!"
    '')
          ];

  # Manage dotfiles using home.file
  home.file = {
    ".config/hypr".source       = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/hypr";
    ".config/waybar".source     = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/waybar";
    ".config/wofi".source       = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/wofi";
    ".config/nvim".source       = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/nvim";
    ".config/vim/vimrc".source  = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/vimrc";
    ".config/alacritty".source  = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/alacritty";
    ".config/btop".source       = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/btop";
    ".gitconfig".source         = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/.gitconfig";
    ".bash_aliases".source      = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/bash/aliases";
    ".bashrc".source            = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/bash/bashrc";
  };

  # Set environment variables
  home.sessionVariables = {
    EDITOR = "vim";
    DOTS   = "Personal";
  };

  # Dont change even when updating.
  home.stateVersion = "24.11"; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Esto es un toque de información necesaria para lo que sería nuestra "nube"
  programs.git = {
    enable = true;
    userName = "luca-desk";
    userEmail = "lukita@duck.com";
  };

}
