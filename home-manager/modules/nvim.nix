{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    neovim
    fzf
    lazygit
    ripgrep
    fd
    curl
    gcc
    nodejs
    tree-sitter
  ];
}