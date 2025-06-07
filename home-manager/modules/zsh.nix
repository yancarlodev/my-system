{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    defaultKeymap = "viins";  # or "emacs"

    # History configuration
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 10000;
      share = true;
      size = 10000;
    };

    # Shell aliases
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -l";
      la = "ls -A";
      lla = "ls -lA";
      g = "git";
      gs = "git status";
      gd = "git diff";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      n = "nix";
      ns = "nix-shell";
      nd = "nix develop";
      hm = "home-manager";
    };

    # Oh My Zsh configuration
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "vi-mode"
        "direnv"
      ];
      theme = "robbyrussell";  # Can be changed to any OMZ theme
      #custom = "${../dotfiles/oh-my-zsh/custom}";  # Path to your customizations
    };

    # Custom init commands
    initExtra = ''
      # Set default editor
      export EDITOR=vim
      export VISUAL=vim

      # Improve history
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_FIND_NO_DUPS

      # Load additional completions
      fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)

      # Custom prompt additions
      PROMPT='%F{blue}%n@%m%f %F{green}%~%f %# '
    '';

    # Local configuration (will be sourced last)
    localVariables = {
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=8";
      DISABLE_MAGIC_FUNCTIONS = "true";  # Fix pasting with zsh-autosuggestions
    };
  };

  # Required packages
  home.packages = with pkgs; [
    zsh
    oh-my-zsh
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
    nix-zsh-completions
  ];
}