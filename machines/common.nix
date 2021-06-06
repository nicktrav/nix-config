{ config, pkgs, ... }:

{
  imports = [
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
}