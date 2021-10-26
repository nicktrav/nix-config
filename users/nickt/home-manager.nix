{ pkgs, ... }:

{
  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/git.nix
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
    go
    jq
    kubectx
    kubectl
    lsof
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
  ]);
}
