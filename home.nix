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
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "git"
        "syntax-highlighting"
        "prompt"
      ];
    };
    initExtra = "bindkey '^e' autosuggest-accept";
  };

  home.file.".config/nvim" = {
    source = builtins.fetchGit {
      url = "https://github.com/a7vinx/axnvim.git";
      rev = "98fd4af2bdd9fb72c2295c5b776449ffd64436a4";
    };
  };

  programs = {
    tmux.enable = true;
    htop.enable = true;
    btop.enable = true;
    bat.enable = true;
    fzf.enable = true;
  };

}
