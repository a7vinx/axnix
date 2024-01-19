{ config, pkgs, ... }:

{
  imports = [
    ./pkgs/frpc.nix
  ];

  services.openssh.enable = true;

  services.frpc = {
    enable = true;
    role = "client";
    configFile = "/home/secrets/frpc-conf";
  };
}
