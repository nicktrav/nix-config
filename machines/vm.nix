inputs: inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "21.05"; }

    inputs.home-manager.nixosModules.home-manager

    {
      imports = [
        ./vm
        ../profiles/desktop.nix
        ../users/nickt.nix
      ];
    }
  ];
}
