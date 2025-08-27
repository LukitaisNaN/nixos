{ config, pkgs, ... }:

{
  home.username = "luki-desk";
  home.homeDirectory = "/home/luki-desk";

  home.packages = with pkgs; [
    # Escribí acá las aplicaciones que quieras instalar.
    # Podés buscar cómo se llaman en https://search.nixos.org/packages
    # Después de agregar o eliminar alguna, escribí "Rebuild" en una terminal.
    # No te olvides de usar "Save" de vez en cuando =).
    
    # Estos son los comandos que hice para que no los tengas que hacer
    # manualmente.

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

  };

  # Tenés ganas de leer?

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
