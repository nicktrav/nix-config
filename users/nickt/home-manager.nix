{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/fzf.nix
    ./../../pkgs/git
    ./../../pkgs/htop.nix
    ./../../pkgs/i3
    ./../../pkgs/jetbrains
    ./../../pkgs/tmux
    ./../../pkgs/vim
    ./wallpaper.nix
  ];

  xdg.enable = true;

  home.packages = (with pkgs; [
    autoconf
    binutils
    certigo
    cmake
    curl
    dig
    file
    firefox
    gcc
    gnumake
    openjdk
    jq
    kubectx
    kubectl
    libedit
    lsof
    m4
    ncurses
    nix-prefetch-git
    nix-index
    nodejs
    opensc
    patchelf
    ripgrep
    shellcheck
    ssh-agents
    stdenv.cc.cc.lib
    tree
    unzip
    usbutils
    wget
    whois
    yacc
    yubico-piv-tool
    yubikey-manager
    yubioath-desktop
  ]) ++ (with pkgs-unstable; [
    _1password
    _1password-gui
    bazel_4
    bazelisk
    go
    go-tools
    google-chrome
  ]);
}
