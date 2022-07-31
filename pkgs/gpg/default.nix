{ config, lib, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
      pcsc-shared = true;
    };
  };

  services.gpg-agent = lib.mkIf (pkgs.stdenv.isLinux) {
    enable = true;
    pinentryFlavor = "curses";
  };
}
