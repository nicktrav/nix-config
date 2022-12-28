{ config, lib, pkgs, ... }:

with pkgs; {
  home.packages = [
    yubico-piv-tool
    yubikey-manager
    (lib.mkIf (pkgs.stdenv.isLinux) yubioath-flutter)
  ];
}
