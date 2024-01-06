{
  description = "axdev-clang";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = {self, nixpkgs }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in
      {
        devShells."x86_64-linux".default =
          pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {};
      };
}
