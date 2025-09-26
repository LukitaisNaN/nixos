{ inputs, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clang         # C LLVM
    clang-tools   # clangd
  ];
}
