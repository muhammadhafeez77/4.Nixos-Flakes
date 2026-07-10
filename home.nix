{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
  ];

  home.username = "coffee";
  home.homeDirectory = "/home/coffee";
  home.stateVersion = "26.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos btw";
      nrs = "sudo nixos-rebuild switch";
      nrsf = "sudo nixos-rebuild switch --flake /etc/nixos/#nixos-btw";
      cdcc = "cd /etc/nixos/";
      vimc = "sudo nvim /etc/nixos/configuration.nix";
      vimh = "sudo nvim /etc/nixos/home.nix";
      vimp = "sudo nvim /etc/nixos/packages.nix";
      vimf = "sudo nvim /etc/nixos/flake.nix";
      vimq = "sudo nvim ~/.config/qtile/config.py";

    };

    initExtra = ''
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';
  };

  programs.git.enable = true; #### GITHUB

  home.sessionPath = [ "$HOME/.config/emacs/bin" ];

  home.sessionVariables = {
    #### SESSION VARIALES
    PATH = "$HOME/.npm-global/bin:$PATH";
  };


  programs.vim = {
    #### VIM 
    enable = true;
    extraConfig = ''
      set clipboard=unnamedplus
    '';
  };

  programs.alacritty = {
    #### ALACRITTY
    enable = true;
    settings = {
      window = {
        opacity = 0.96;
        padding = { y = 6; x = 6; };
      };
      font = {
        size = 8;
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
      };
      keyboard.bindings = [
        { key = "V"; mods = "Control"; action = "Paste"; }
        { key = "C"; mods = "Control|Shift"; action = "Copy"; }
      ];
    };
  };

}
