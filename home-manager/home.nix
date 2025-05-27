{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  xdg.configFile."hypr/hyprland.conf" = {
    source = ./config/hypr/hyprland.conf;
    force = true;
  };

  xdg.configFile."hypr/hyprpaper.conf".source = ./config/hypr/hyprpaper.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./config/hypr/hyprlock.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./config/hypr/hypridle.conf;
  xdg.configFile."git/config".source = ./config/git/config;

  home.file.".icons".source = ../assets/themes/hyprcursor;

  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "yanlepri";
    homeDirectory = "/home/yanlepri";
  };

  home.packages = with pkgs; [
    vim
    bat
    
    zsh
    oh-my-zsh
    
    brave
    google-chrome
    
    spotify
    discord
    
    vscode
    jetbrains.webstorm
    jetbrains.idea-ultimate
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}