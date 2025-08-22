{ config, pkgs, ... }:

# I should modularize this
let
  homeDir = config.home.homeDirectory;
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.username = "lukita";
  home.homeDirectory = "/home/lukita";

  programs.git = {
    enable = true;
    userName = "Lukita";
    userEmail = "luca.irrazabal@mi.unc.edu.ar";
  };


  # home.packages allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    audacity      # Audio editor
    bitwig-studio # DAW
    dconf         # Dependancy
    dconf-editor  # GSettings editor
	delta		  # Git pager
    diff-so-fancy # Better git diff
    lzip          # WayDroid_Script dependancy
    lsd           # Better ls
    networkmanagerapplet
    toxic         # Lightweight Discord
    themix-gui    # Gtk customizer
    font-awesome  # Font
    git-lfs       # Git large file storage
    unrar         # rar uncompressor

    # Rebuild
    (writeShellScriptBin "Rebuild" ''
      sudo nixos-rebuild switch --flake ~/.config/nixos/#lukitaOs
    '')

    # Push
    (writeShellScriptBin "Save" ''
      cd ~/.config/nixos
      git add .
      git commit -m "$USER's automatic backup"
      git fetch
      git rebase
      git push
      cd ~/
    '')

    # Pull
    (writeShellScriptBin "Update" ''
      cd ~/.config/nixos
      git fetch
      git rebase
      cd 
    '')

  ];

  # Manage dotfiles
  home.file = {
    ".config/hypr".source 		= symlink "${config.home.sessionVariables.DOTS}/$DOTS/hypr";
    ".config/waybar".source 	= symlink "${homeDir}/${config.home.sessionVariables.DOTS}/waybar";
    ".config/nvim".source 		= symlink "${homeDir}/${config.home.sessionVariables.DOTS}/nvim";
    ".config/vim/vimrc".source 	= symlink "${homeDir}/${config.home.sessionVariables.DOTS}/vimrc";
	".config/alacritty".source 	= symlink "${homeDir}/${config.home.sessionVariables.DOTS}/alacritty";
	".config/btop".source		= symlink "${homeDir}/${config.home.sessionVariables.DOTS}/btop";
	".gitconfig".source			= symlink "${homeDir}/${config.home.sessionVariables.DOTS}/gitconfig";
	".bash_aliases".source		= symlink "${homeDir}/${config.home.sessionVariables.DOTS}/bash/aliases";
	".bashrc".source			= symlink "${homeDir}/${config.home.sessionVariables.DOTS}/bash/bashrc";
  };

  # Set environment variables
  home.sessionVariables = {
    EDITOR = "vim";
	DOTS = "Personal";
  };

  # Dont change even when updating.
  home.stateVersion = "24.11"; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
