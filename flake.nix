{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-21.05";
    };
  };

  outputs = inputs: {
    nixosConfigurations = {
      x1 = import ./machines/x1.nix inputs;
    };
  };
}
