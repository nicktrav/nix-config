{ nixpkgs, nixos-hardware, ... }:

{
  imports = [
    nixos-hardware.nixosModules.raspberry-pi-4
  ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/dev/disk/by-label/swap";
  }];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  # Required for the Wireless firmware
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.gpgSmartcards.enable = true;

  nixpkgs.hostPlatform = nixpkgs.lib.mkDefault "aarch64-linux";
  powerManagement.cpuFreqGovernor = nixpkgs.lib.mkDefault "ondemand";
}
