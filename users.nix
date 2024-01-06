{ config, pkgs, ... }:

{
  imports = [];

  # Get zsh-completion for system packages (e.g. systemd).
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;

  users.users.arvinx = {
    isNormalUser = true;
    description = "Arvin Hsu";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA1dbhS58A6qfq28ynJRliK8NbyDh0iq+mfPqPiGyE3g axcore-windows"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBC7yu2BKXn22kHy8KTLQH8URzvT8SrS2sjjrzLSg6O6 axws-edge"
    ];
  };
}
