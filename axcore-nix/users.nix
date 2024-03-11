{ config, pkgs, ... }:
{
  imports = [];

  users.groups.time-machine.members = [
    "tm-axcore-nix"
  ];
  users.users.tm-axcore-nix = {
    isSystemUser = true;
    group = "time-machine";
  };
}
