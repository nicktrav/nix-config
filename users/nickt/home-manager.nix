{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/dict.nix
    ./../../pkgs/direnv.nix
    ./../../pkgs/fzf.nix
    ./../../pkgs/git
    ./../../pkgs/htop.nix
    ./../../pkgs/i3
    ./../../pkgs/jetbrains
    ./../../pkgs/tmux
    ./../../pkgs/vim
    ./../../pkgs/x
    ./wallpaper.nix
  ];

  xdg.enable = true;

  home.packages = (with pkgs; [
    binutils
    certigo
    curl
    dig
    file
    jq
    lsof
    nix-prefetch-git
    opensc
    ripgrep
    shellcheck
    ssh-agents
    tree
    unzip
    usbutils
    whois
    xclip
    yubico-piv-tool
    yubikey-manager
    yubioath-desktop
  ]) ++ (with pkgs-unstable; [
    _1password
    _1password-gui
    go
    google-chrome
  ]);
}
