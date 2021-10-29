{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/fzf.nix
    ./../../pkgs/git
    ./../../pkgs/htop.nix
    ./../../pkgs/jetbrains.nix
    ./../../pkgs/tmux
    ./../../pkgs/vim
  ];

  home.packages = (with pkgs; [
    certigo
    curl
    dig
    firefox
    jq
    kubectx
    kubectl
    lsof
    nix-prefetch-git
    opensc
    ripgrep
    shellcheck
    ssh-agents
    tree
    unzip
    usbutils
    wget
    whois
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
