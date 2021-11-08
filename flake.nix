{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-21.05";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NIxOS/nixos-hardware";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware }:
  let
    mkmachine = import ./lib/mkmachine.nix;
  in {
    nixosConfigurations = {
      vm = mkmachine "vm" {
        inherit nixpkgs nixpkgs-unstable home-manager nixos-hardware;
        system = "x86_64-linux";
        user   = "nickt";
      };
      x1 = mkmachine "x1" {
        inherit nixpkgs nixpkgs-unstable home-manager nixos-hardware;
        system = "x86_64-linux";
        user   = "nickt";
      };
    };
  };
}
