{ config, pkgs, ... }:

{
  imports = [
    ./common-base.nix
    ./fonts.nix
    ./users.nix
  ];

  # Allow unfree software.

  nixpkgs.config.allowUnfree = true;

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

  services.openssh = {
    passwordAuthentication = false;
    permitRootLogin = "no";
    challengeResponseAuthentication = false;
  };

  # System packages.

  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
  ];
}
