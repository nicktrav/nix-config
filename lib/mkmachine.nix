# This function creates a NixOS system based on our VM setup for a
# particular architecture.
name: { nixpkgs, home-manager, nixos-hardware, system, user }:

let
  pkgs = nixpkgs;
  lib = pkgs.lib;
  hardware = (./.. + "/hardware/${name}.nix");
  machine = (./.. + "/machines/${name}.nix");

in
nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    home-manager.nixosModules.home-manager
    (import hardware { inherit lib pkgs nixos-hardware; })
    machine
    ../users/nickt/nixos.nix
    {
      config._module.args = {
        currentSystem = system;
      };
    }
  ];
}
