inputs: inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    { system.stateVersion = "21.05"; }
    ({ config, lib, pkgs, modulesPath, ... }: {
      imports = [
        ./users.nix
        (modulesPath + "/profiles/qemu-guest.nix")
      ];

      # Enable flakes.
      nix.package = pkgs.nixUnstable;
      nix.extraOptions = ''
        experimental-features = nix-command flakes
      '';

      # Boot.

      boot.loader.grub.enable = true;
      boot.loader.grub.version = 2;
      boot.loader.grub.devices = ["/dev/sda"];
      boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "ehci_pci" "usb_storage" "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      # Disks.

      fileSystems."/" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-label/home";
        fsType = "ext4";
      };

      swapDevices = [{
        device = "/dev/disk/by-label/swap";
      }];

      # Remove once done testing.
      fileSystems."/nix-config" = {
        device = "/share";
        fsType = "9p";
        options = [ "trans=virtio" "version=9p2000.L" "rw" ];
      };

      # Networking.

      networking.hostName = "nickt";
      networking.useDHCP = false;
      networking.interfaces.ens3.useDHCP = true;

      # System services.

      #services.xserver.enable = true;
      #services.xserver.desktopManager.gnome.enable = true;
      #services.xserver.displayManager.gdm.enable = true;
      services.openssh.enable = true;

      # System packages.

      environment.systemPackages = with pkgs; [
        git
      ];

      # Time.

      time.timeZone = "America/Los_Angeles";
    })
  ];
}
