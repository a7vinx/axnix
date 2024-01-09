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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINygwNSMQYpHle3jVoFTd66DBPJV/JNSA6RcjvK4tZUl axws-edge"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGZWZFUT61DAymiux7LRw5AmcOj7xCCIkRcvCAhGovry axedge-phone"
    ];
  };
}
