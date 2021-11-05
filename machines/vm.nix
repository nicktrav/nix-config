{ config, ... }:

{
  imports = [
    ./shared.nix
  ];

  # Virtualization settings.
  virtualisation.vmware.guest.enable = true;

  # Interface is this on Intel Fusion.
  networking.interfaces.ens33.useDHCP = true;
}
