{ config, ... }:

{
  imports = [
    ./shared.nix
  ];

  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.enp45s0u2.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  networking.networkmanager.enable = true;
}
