{ inputs, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-language-server        # Bash
    clang                       # C LLVM
    clang-tools                 # clangd
    cmake-language-server       # Make
    lua-language-server         # Lua
    nil                         # Nix
    rust-analyzer               # Rust
    ty                          # Python
    vscode-css-languageserver   # CSS
    vscode-json-languageserver  # Json

  ];
}
