{ nixgl-pkgs, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./../../pkgs/jetbrains
    ./../../pkgs/x
  ];

  home.packages = (with pkgs; [
    _1password
    _1password-gui
    bazelisk
    binutils
    ccache
    gnome3.gnome-tweaks
    gnumake
    google-chrome
    google-cloud-sdk
    inconsolata
    openjdk
    patchelf
    powerline-fonts
    pprof
    python2
    openjdk
    rsync
    usbutils
    xclip
    yarn
    yubioath-desktop
  ]) ++ (with nixgl-pkgs; [
    nixgl.nixGLIntel
  ]);
}
