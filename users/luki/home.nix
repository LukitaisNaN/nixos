{ config, pkgs, ... }:

{
  home.username = "lukita";
  home.homeDirectory = "/home/lukita";

  # home.packages allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    lmms
    bitwig-studio
    toxic
    #pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses.
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # Create simple shell scripts directly inside your configuration.     
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Rebuild
    (writeShellScriptBin "Rebuild" ''
      sudo nixos-rebuild switch --flake ~/.config/nixos/#lukitaOs
    '')

    # Push
    (writeShellScriptBin "Save" ''
      cd ~/.config/nixos
      git add .
      git commit -m "$USER's automatic backup"
      git push
      cd ~/
    '')

    # Pull
    (writeShellScriptBin "Update" ''
      cd ~/.config/nixos
      git fetch
      git merge
      cd 
    '')

  ];

  # Manage dotfiles using home.file
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lukita/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Dont change even when updating.
  home.stateVersion = "24.11"; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Lukita";
    userEmail = "luca.irrazabal@mi.unc.edu.ar";
  };

}
