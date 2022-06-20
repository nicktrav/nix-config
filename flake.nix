{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware }:
    let
      mkmachine = import ./lib/mkmachine.nix;
    in
    {
      inherit nixpkgs;
      nixosConfigurations = {
        vm = mkmachine "vm" {
          inherit nixpkgs home-manager nixos-hardware;
          system = "x86_64-linux";
          user = "nickt";
        };
        x1 = mkmachine "x1" {
          inherit nixpkgs home-manager nixos-hardware;
          system = "x86_64-linux";
          user = "nickt";
        };
      };
    };
}
