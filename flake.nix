{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-21.05";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
  let
    mkmachine = import ./lib/mkmachine.nix;
  in {
    nixosConfigurations = {
      vm = mkmachine "vm" {
        inherit nixpkgs nixpkgs-unstable home-manager;
        system = "x86_64-linux";
        user   = "nickt";
      };
    };
  };
}
