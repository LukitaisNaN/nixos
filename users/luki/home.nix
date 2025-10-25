{ config, pkgs, ... }:

  let
    homeDir = config.home.homeDirectory;
    symlink = config.lib.file.mkOutOfStoreSymlink;
  in
  {

  imports = [
    ./db.nix
  ];

    home.username = "lukita";
    home.homeDirectory = "/home/lukita";

    programs.git = {
      enable = true;
      user.name = "Lukita";
      user.email = "luca.irrazabal@mi.unc.edu.ar";
    };

    # home.packages allows you to install Nix packages into your environment.
    home.packages = with pkgs; [
      audacity      # Audio editor
      clang         # C LLVM
      clang-tools   # clangd
      dconf         # Dependancy
      dconf-editor  # GSettings editor
      delta         # Pager
      diff-so-fancy # Better git diff
      gh            # Github Cli
      jq            # Command Line json processor. Used in hypr/bin/smartcritty.sh
      lzip          # WayDroid_Script dependancy
      lsd           # Better ls
      networkmanagerapplet
      toxic         # Lightweight Discord
      themix-gui    # Gtk customizer
      font-awesome  # Font
      git-lfs       # Git large file storage
      unrar         # rar uncompressor
      onlyoffice-desktopeditors
      postman
      sl
      showmethekey
      syncthing
      vscode
      wev

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
      ".config/hypr".source         = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/hypr";
      ".config/waybar".source       = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/waybar";
      ".config/wofi".source         = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/wofi";
      ".config/nvim".source         = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/nvim";
      ".config/vim/vimrc".source    = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/vimrc";
      ".config/alacritty".source    = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/alacritty";
      ".config/btop".source         = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/btop";
      ".gitconfig".source           = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/.gitconfig";
      ".bash_aliases".source        = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/bash/aliases";
      ".bashrc".source              = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/bash/bashrc";
      ".config/helix".source        = symlink "${homeDir}/${config.home.sessionVariables.DOTS}/helix";
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

    services.wlsunset = {
      enable = true;
      latitude = -31;
      longitude = -64;
    };
}
