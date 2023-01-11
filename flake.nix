{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL/main";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, darwin, nixgl }:
    {
      inherit nixpkgs nixos-hardware;

      nixosConfigurations = {
        x1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            (import ./hardware/x1.nix { inherit nixpkgs nixos-hardware; })
            ./machines/x1.nix
          ];
        };
        vm = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            (import ./hardware/vm.nix { inherit nixos-hardware; })
            ./machines/vm.nix
          ];
        };
      };

      darwinConfigurations = {
        mbp = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            ./machines/mbp.nix
          ];
        };
      };

      homeConfigurations =
        let
          system = "x86_64-linux";

        in
        {
          xps = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
              inherit system;
              # See https://github.com/nix-community/home-manager/issues/2942.
              config.allowUnfree = true;
            };
            modules = [
              ./machines/xps.nix
            ];
            # Pass through nixgl overlayed onto the pkgs.
            # See: https://github.com/guibou/nixGL#use-an-overlay
            extraSpecialArgs =
              let
                nixgl-pkgs = import nixpkgs {
                  inherit system;
                  overlays = [ nixgl.overlay ];
                };
              in
              {
                inherit nixgl-pkgs;
              };
          };
        };
    };
}
