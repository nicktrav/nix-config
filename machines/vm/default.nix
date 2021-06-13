inputs: { config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
    "${modulesPath}/profiles/qemu-guest.nix"
    ../../profiles/base.nix
  ];

  # Networking.

  networking.hostName = "nickt";
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  # Boot.

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "ehci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Disks.

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

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

  fileSystems."/nix-config" = {
    device = "/share";
    fsType = "9p";
    options = [ "trans=virtio" "version=9p2000.L" "rw" ];
  };
}
