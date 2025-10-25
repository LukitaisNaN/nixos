{ config, pkgs, ... }:

{
  home.username = "ebo";
  home.homeDirectory = "/home/ebo";

  home.packages = with pkgs; [
    # Escribí acá las aplicaciones que quieras instalar.
    # Podés buscar cómo se llaman en https://search.nixos.org/packages
    # !! Después de agregar o eliminar alguna, escribí "Rebuild" en una terminal.
    # No te olvides de usar "Save" de vez en cuando =).

    kdePackages.okular  # Editor de pdf
    zoom-us             # Zoom

    # Estos son los comandos que hice para que no los tengas que hacer
    # manualmente.

    # Help
    (pkgs.writeShellScriptBin "Help" ''
      cat << EOF
      omg!!! $USER needs help!!! Acá están los comandos que se pueden usar,
      fijate que empiezan con mayúscula.
      "Edit":    Usalo cuando quieras instalar algún programa, te va a abrir un
                   archivo de configuración.
                 Ahí está explicado qué hacer.
      "Rebuild": Usalo después de "Edit" para instalar los programas que hayas agregado.
      "Save":    Por si querés guardar en la nube los cambios que hiciste.
      "Update":  Descarga los cambios que haya en la nube. Normalmente
                   te voy a indicar cuando haga falta usar este comando =).
      EOF
      '')

    # Clone github repository.
    (writeShellScriptBin "Init" ''
      echo "Checking if nix configuration folder exists..."
      if [ ! -d "~/.config/nixos"]; then
        echo "Creating nix configuration directory..."
        mkdir -p ~/.config/
        cd ~/.config/
        echo "Downloading github repository..."
        git clone https://github.com/LukitaisNaN/nixos.git
        echo "OK!"
      else
        echo "Directory already exists, skiping clonation..."
        cd ~/.config/nixos
        git remote set-url origin git@github.com:LukitaisNaN/nixos.git
      fi

      cd

      if [ -d "~/Desktop"]; then
        ln -s ~/.config/nixos/users/ebo/home.nix ~/Desktop/apps.nix
      else
        ln -s ~/.config/nixos/users/ebo/home.nix ~/Escritorio/apps.nix
      fi

      Rebuild

      cat <<EOF
      Ahora se va a generar una clave que es necesaria para la nube.
      Te va a pedir un par de cosas no hace falta que escribas nada, solo tocá enter.
      EOF

      ssh-keygen
      echo "Ahora pasame lo de acá abajo por wsp :P"
      cat ~/.ssh/id*.pub
      Git-Fix
    '')

    # Edit config file
    (writeShellScriptBin "Edit" ''
      nano ~/.config/nixos/users/ebo/home.nix
    '')

    # Rebuild
    (writeShellScriptBin "Rebuild" ''
      sudo nixos-rebuild switch --flake ~/.config/nixos/#eborito
    '')

    # Push
    (writeShellScriptBin "Save" ''
      touch ~/tmp
      pwd > ~/tmp
      cd ~/.config/nixos
      git add .
      git commit -m "$USER's automatic backup"
      git fetch
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
      git fetch
      git rebase
      cd
      echo "Updating..."
      Rebuild
      echo "Update finished!"
    '')

    # Change git upstream link to do it trough ssh
    (writeShellScriptBin "Git-Fix" ''
      cd ~/.config/nixos
      git remote set-url origin git@github.com:LukitaisNaN/nixos.git
      cd
    '')

  ];

  # Manage dotfiles using home.file
  home.file = {

  };

  # Tenés ganas de explorar?

  home.sessionVariables = {
    EDITOR = "nano";
  };

  # Dont change even when updating.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Esto es un toque de información necesaria para lo que sería nuestra "nube"
  programs.git = {
    enable = true;
    userName = "Evo";
    userEmail = "evoryplata2022@gmail.com";
  };

}
