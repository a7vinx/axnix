{ config, pkgs, ... }:

let
  vscodeModSrc = {
    url = "https://github.com/msteen/nixos-vscode-server/tarball/1e1358493df6529d4c7bc4cc3066f76fd16d4ae6";
    sha256 = "0sz8njfxn5bw89n6xhlzsbxkafb6qmnszj4qxy2w0hw2mgmjp829";
  };
in {
  imports = [
    "${fetchTarball vscodeModSrc}/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;

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

  programs = {
    tmux.enable = true;
    htop.enable = true;
    btop.enable = true;
    bat.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
  };

}
