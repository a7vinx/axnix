{
  description = "axnix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs : {
    nixosConfigurations = {
      arvinx = home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;

        home-manager.users.arvinx = import ./home.nix;
      };

      axcore-nix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./base.nix
	  ./users.nix
	  ./virtualisation.nix
	  ./services.nix
	  ./axcore-nix/hardware.nix
	  ./axcore-nix/network.nix
	  ./axcore-nix/gui.nix
	  ./axcore-nix/mounts.nix
	  ./axcore-nix/services.nix

          arvinx
        ];
      };

      axws-core = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          arvinx
        ];
      };

    };
  };
}
