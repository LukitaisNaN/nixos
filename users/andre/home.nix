{ config, pkgs, ... }:

{
  home.username = "chuchu";
  home.homeDirectory = "/home/chuchu";

  home.packages = with pkgs; [
    # Escribí acá las aplicaciones que quieras instalar.
    # Podés buscar cómo se llaman en https://search.nixos.org/packages
    # Después de agregar o eliminar alguna, escribí "Rebuild" en una terminal.
    # No te olvides de usar "Save" de vez en cuando =).
    brave               # Navegador
    brightnessctl       # Para subir y bajar el brillo
    kdePackages.okular  # Editor de pdf
    onlyoffice-desktopeditors
    zoom-us             # Por si tu mamá lo necesita, es zoom, solo tiene un nombre raro
    
    # Para guardar tocá Ctrl+x, 's' y enter.

    # Estos son los comandos que hice para que no los tengas que hacer
    # manualmente.

    # Help
    (pkgs.writeShellScriptBin "Help" ''
      cat << EOF
      omg!!! Andre needs help!!! Te dejo por acá los comandos que podés usar, 
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

    # Clone github repository. Don't use or it will restore config. (I think)
    (pkgs.writeShellScriptBin "Init" ''
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
      fi

      cd
      ln -s ~/.config/nixos/users/andre/home.nix ~/apps.nix

      Rebuild

      cat << EOF
      Tu contraseña es "1212". Ahora te va a pedir que la cambies.
      Te va a pedir tu contraseña actual, poné "1212" (Sin las comillas, por si acaso)
      Después tenés que poner tu nueva contraseña. Te va a pedir repetirla.
      Si algo sale mal, podés usar "passwd $(USER)" para volver a intentarlo.
      EOF

      sudo passwd chuchu

      cat <<EOF
      Ahora se va a generar una clave que es necesaria para la nube, 
      Te va a pedir un par de cosas no hace falta que escribas nada, solo tocá enter.
      EOF

      ssh-keygen
      echo "Ahora pasame lo de acá abajo por wsp :P"
      cat ~/.ssh/id*.pub
    '')

    # Edit config file
    (pkgs.writeShellScriptBin "Edit" ''
      nano ~/.config/nixos/users/andre/home.nix
    '')

    # Rebuild
    (pkgs.writeShellScriptBin "Rebuild" ''
      sudo nixos-rebuild switch --flake ~/.config/nixos/#andreOs
    '')

    # Push
    (pkgs.writeShellScriptBin "Save" ''
      touch ~/tmp
      pwd > ~/tmp
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
    (pkgs.writeShellScriptBin "Update" ''
      cd ~/.config/nixos
      git fetch
      git merge
      cd 
      echo "Update finished!"
    '')
  ];

  # Manage dotfiles using home.file
  home.file = {

  };

  # Tenés ganas de explorar?

  home.sessionVariables = {
    EDITOR = "vim";           # Change for an easier one. Maybe atom? idk.
  };

  # Dont change even when updating.
  home.stateVersion = "24.11"; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Esto es un toque de información necesaria para lo que sería nuestra "nube"
  programs.git = {
    enable = true;
    userName = "Chuchu";
    userEmail = "andreachinagonzalez@gmail.com";
  };

}
