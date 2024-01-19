{ config, pkgs, ... }:

{
  imports = [
  ];

  services.openssh.enable = true;

  services.frpc = {
    enable = true;
    role = "client";
    configFile = "/home/secrets/frpc-conf";
  };
}
