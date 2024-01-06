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
      axcore-nix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
	  ./hardware.nix
          ./base.nix
	  ./users.nix
	  ./mounts.nix
	  ./services.nix
	  ./virtualisation.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.arvinx = import ./home.nix;
          }
        ];

      };
    };
  };
}
