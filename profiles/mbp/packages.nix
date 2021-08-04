{ config, pkgs, lib, ... }:

with lib;

let

  callPackage = callPackageWith pkgs;

  jdk-custom = (callPackage ./../../packages/openjdk {});

in {

  # Enable bash, disable zsh (the default).
  programs.bash.enable = true;
  programs.zsh.enable = false;  # default shell on catalina

  # Home-manager default packages.
  home.packages = (with pkgs; [
    certigo
    curl
    dig
    file
    go
    golint
    jetbrains.goland
    jdk-custom
    jq
    kubectx
    kubectl
    lsof
    opensc
    ripgrep
    shellcheck
    openssh
    ssh-agents
    tree
    unzip
    wget
    which
    whois
    yubico-piv-tool
    yubikey-manager
  ]);

  # Custom packages.
  imports = [
    ./../../packages/alacritty.nix
    ./../../packages/bash
    ./../../packages/git.nix
    ./../../packages/htop.nix
    ./../../packages/jetbrains
    ./../../packages/tmux
    ./../../packages/vim
  ];
}
