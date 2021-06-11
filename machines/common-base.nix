{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
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

  # SSH.

  services.openssh.enable = true;

  # TODO: import directly from GitHub.
  users.users.root.openssh.authorizedKeys.keyFiles = [
    ./authorized_keys
  ];

  # System packages.

  environment.systemPackages = with pkgs; [
    git
  ];

  # Time.

  time.timeZone = "America/Los_Angeles";
}

