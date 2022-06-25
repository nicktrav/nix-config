{ config, lib, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
      pcsc-shared = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };
}
