{ config, pkgs, ... }:

{
  imports = [
    ./users.nix
  ];

  # Boot.

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Disks.

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fdType = "ext4";
  };

  # Networking.

  networking.hostName = "nickt";
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  # System services.

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.openssh.enable = true;

  # System.

  system.stateVersion = "21.05";

  # Time.

  time.timeZone = "America/Los_Angeles";
}
