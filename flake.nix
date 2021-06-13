{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-21.05";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations = {
      vm = import ./machines/vm.nix inputs;
      vm-minimal = import ./machines/vm-minimal.nix inputs;
      x1 = import ./machines/x1.nix inputs;
    };
  };
}
