{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;

    theme = {
      name = "gruvbox-dark-gtk";
      package = pkgs.gruvbox-dark-gtk;
    };

    iconTheme = {
      name = "gruvbox-dark-icons-gtk";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };

  xdg.configFile = {
    "hypr/hyprland.conf" = {
      source = ./config/hypr/hyprland.conf;
      force = true;
    };
    "hypr/hyprpaper.conf".source = ./config/hypr/hyprpaper.conf;
    "hypr/hyprlock.conf".source = ./config/hypr/hyprlock.conf;
    "hypr/hypridle.conf".source = ./config/hypr/hypridle.conf;
    
    "waybar/config.jsonc".source = ./config/waybar/config.jsonc;
    "waybar/style.css".source = ./config/waybar/style.css;
    
    "git/config".source = ./config/git/config;

    "gtk-4.0/gtk.css".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/gtk-3.0/gtk.css";
  };

  home.file.".icons".source = ../assets/icons;

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
    lolcat
    
    zsh
    oh-my-zsh
    
    brave
    google-chrome
    
    spotify
    discord
    
    vscode
    jetbrains.webstorm
    jetbrains.idea-ultimate
    whatsapp-for-linux
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}