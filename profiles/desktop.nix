{ config, pkgs, inputs, ... }:

{
  # Allow unfree software.

  nixpkgs.config.allowUnfree = true;

  # Fonts.

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      inconsolata
      powerline-fonts
    ];
  };

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

