{ config, pkgs, ... }:

{
  home.username = "arvinx";
  home.homeDirectory = "/home/arvinx";

  home.stateVersion = "23.11";
  home.packages = with pkgs;[
  ];

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    shellAliases = {
      vi = "nvim";
    };
    prezto = {
      enable = true;
      editor.keymap = "vi";
      prompt.theme = "sorin";
    };
    initExtra = "bindkey '^e' autosuggest-accept";
  };

  # home.file.".config/nvim" = {
  #   source = ./nvim;
  # };

  programs = {
    tmux.enable = true;
    htop.enable = true;
    btop.enable = true;
    bat.enable = true;
    fzf.enable = true;
  };

}
