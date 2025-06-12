{ pkgs }:

{
    environment.systemPackages = with pkgs; [
      alejandra # Nix code formatter
      ant
      diff-so-fancy
      jdk11
      pyright
      tmux
      tree
    ];
}


