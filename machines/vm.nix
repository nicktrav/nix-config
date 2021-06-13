inputs: inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules =
    let
      # Allow for use of both stable and unstable packages.
      # See: https://github.com/nix-community/home-manager/issues/1538
      defaults = { pkgs, ... }: {
        _module.args.pkgs-unstable =
          import inputs.nixpkgs-unstable { inherit (pkgs.stdenv.targetPlatform) system; };
      };
    in [
      defaults
      { system.stateVersion = "21.05"; }
      inputs.home-manager.nixosModules.home-manager
      {
        imports = [
          (import ./vm inputs)
          ../profiles/desktop.nix
          ../users/nickt.nix
        ];
      }
    ];
}
