{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ./../../pkgs/dict.nix
    ./../../pkgs/i3
    ./../../pkgs/jetbrains
    ./../../pkgs/x
    ./wallpaper.nix
  ];

  xdg.enable = true;

  home.packages = (with pkgs; [
    _1password
    _1password-gui
    binutils
    google-chrome
    libstdcxx5
    pinentry
    rsync
    usbutils
    xclip
    yubioath-desktop
  ]);
}
