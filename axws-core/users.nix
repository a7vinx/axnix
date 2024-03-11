{ config, pkgs, ... }:
{
  imports = [];

  users.groups.time-machine.members = [
    "tm-axws-edge"
  ];
  users.users.tm-axws-edge = {
    isSystemUser = true;
    group = "time-machine";
  };
}
