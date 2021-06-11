{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-21.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations = {
      vm = import ./machines/vm.nix inputs;
      vm-bootstrap = import ./machines/vm-bootstrap.nix inputs;
      x1 = import ./machines/x1.nix inputs;
    };
  };
}
