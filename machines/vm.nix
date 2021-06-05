inputs: inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "21.05"; }

    {
      imports = [
        ./common.nix
        ./vm
      ];
    }

    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.nickt = { ... }: {
        home.stateVersion = "21.05";
        imports = [ ../users/nickt.nix ];
      };
    }
  ];
}
