{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
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
          # The following is a hack to work around the following issue:
          # https://github.com/nix-community/home-manager/issues/2942
          pkgs-unfree = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfreePredicate = (pkg: true);
          };
        in
        {
          xps = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs-unfree;
            system = "x86_64-linux";
            username = "nickt";
            homeDirectory = "/home/nickt";
            stateVersion = "22.05";
            # Pass through nixgl overlayed onto the pkgs.
            # See: https://github.com/guibou/nixGL#use-an-overlay
            extraSpecialArgs =
              let
                nixgl-pkgs = import nixpkgs {
                  system = "x86_64-linux";
                  overlays = [ nixgl.overlay ];
                };
              in
              {
                inherit nixgl-pkgs;
              };
            configuration = import ./users/nickt/xps.nix;
          };
        };
    };
}
