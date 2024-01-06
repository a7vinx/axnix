{ config, pkgs, ... }:

{
  imports = [];

  fileSystems."/mnt/data" = {
    device = "/dev/sdb1";
  };

  fileSystems."/mnt/media" = {
    device = "/dev/sdc2";
  };
}
