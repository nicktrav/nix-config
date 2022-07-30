{ nixgl-pkgs, ... }:

{
  imports = [
    ./common.nix
    ./../../pkgs/jetbrains
    ./../../pkgs/x
  ];

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = (with nixgl-pkgs; [
    _1password
    _1password-gui
    bat
    bazelisk
    binutils
    ccache
    gnome3.gnome-tweaks
    gnumake
    google-chrome
    google-cloud-sdk
    inconsolata
    nixgl.nixGLIntel
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
  ]);

  news.display = "silent";
}
