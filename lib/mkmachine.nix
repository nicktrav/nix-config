# This function creates a NixOS system based on our VM setup for a
# particular architecture.
name: { nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, system, user }:

let
  pkgs = nixpkgs;
  lib = pkgs.lib;

in
nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = let
    # Allow for use of both stable and unstable packages.
    # See: https://github.com/nix-community/home-manager/issues/1538
    defaults = { pkgs, ... }: {
      _module.args.nixpkgs-unstable =
        import nixpkgs-unstable {
          inherit (pkgs.stdenv.targetPlatform) system;
          # Allow unfree packages in unstable.
          # See: https://discourse.nixos.org/t/only-one-nixpkgs-in-a-flake-input-can-allow-unfree/8866
          config.allowUnfree = true;
        };
      };
  in [
    defaults
    home-manager.nixosModules.home-manager
    (import ../hardware/${name}.nix { inherit lib pkgs nixos-hardware; })
    ../machines/${name}.nix
    ../users/nickt/nixos.nix
  ];

  extraArgs = {
    currentSystem = system;
  };
}
