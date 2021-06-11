inputs: inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "21.05"; }

    {
      imports = [
        ./vm
      ];
    }
  ];
}
