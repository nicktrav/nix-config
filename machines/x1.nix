{ config, ... }:

{
  imports = [
    ./shared.nix
  ];

  networking.interfaces.enp45s0u2.useDHCP = true;
}
