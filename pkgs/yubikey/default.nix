{ config, pkgs, ... }:

{
  home.packages = (with pkgs; [
    yubico-piv-tool
    yubikey-manager
  ]);
}
