{ config, pkgs, ... }:

{
  imports = [];

  virtualisation.vmware.guest.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
