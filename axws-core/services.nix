{ config, pkgs, ... }:

{
  imports = [
  ];

  services.samba = {
    enable = true;
    openFirewall = true;
    shares = {
      tm-axws-edge = {
        path = "/mnt/data/time-machine/axws-edge";
	public = "no";
	browsable = "yes";
	writable = "yes";
	"valid users" = "tm-axws-edge";
	"fruit:aapl" = "yes";
	"fruit:time machine" = "yes";
	"vfs objects" = "catia fruit streams_xattr";
      };
    };
  };
}
