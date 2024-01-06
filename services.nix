{ config, pkgs, ... }:

{
  imports = [
    ./pkgs/frpc.nix
  ];

  services.nextcloud = {
    enable = true;
    home = "/mnt/data";
    hostName = "192.168.50.245";
    config.adminpassFile = "/home/secrets/nextcloud-root-pass";
  };

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  services.frpc = {
    enable = true;
    role = "client";
    configFile = "/home/secrets/frpc-conf";
  };

  virtualisation.oci-containers.containers = let
    bdcloudImg = pkgs.dockerTools.pullImage {
      imageName = "a7vinx/bypy";
      imageDigest = "sha256:fc96767da550dd414acf0f0df9d0780059f975a31edf5de62df052caff5ff72b";
      sha256 = "sha256-xVcQUyW5GNzCloUCPwtCcBD/HZYkv945/v+6gRc+KFk=";
    };
  in {
    bdcloud = {
      imageFile = bdcloudImg;
      image = "a7vinx/bypy";
      user = "nobody";
      cmd = [ "--config-dir" "/bypy/conf" "syncdown" "/" "/bypy/data" ];
      volumes = [
        "/mnt/media/bdcloud:/bypy"
      ];
    };
  };

  systemd.services.podman-bdcloud.serviceConfig = {
    Restart = "always";
    RestartSec = 600;
  };
}
