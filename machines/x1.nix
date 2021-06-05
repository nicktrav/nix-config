inputs: inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "21.05"; }
    ({ config, lib, pkgs, modulesPath, ... }: {
      imports = [
        ./hardware-configuration.nix
        ./fonts.nix
        ./users.nix
      ];

      # Enable flakes.
      nix.package = pkgs.nixUnstable;
      nix.extraOptions = ''
        experimental-features = nix-command flakes
      '';

      # Networking.

      networking.hostName = "nickt";
      networking.useDHCP = false;
      networking.interfaces.ens3.useDHCP = true;

      # XServer / Gnome.

      services.xserver = {
        enable = true;

        desktopManager = {
          gnome.enable = true;
        };

        displayManager = {
          gdm.enable = true;
        };
      };

      # SSH.

      services.openssh.enable = true;

      # System packages.

      environment.systemPackages = with pkgs; [
        git
        gnome3.gnome-tweaks
      ];

      # Time.

      time.timeZone = "America/Los_Angeles";

    })

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
