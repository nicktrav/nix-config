{ config, pkgs, ... }:

let

  nixpkgs-latest = pkgs.fetchgit {
    url = https://github.com/NixOS/nixpkgs;
    rev = "46450f2f65f117459157e4ea90e39c6601e38109"; # nixpkgs-21.11-darwin
    sha256 = "134j3ph5q874jrxy9l4bszq1zwpiwvmf916igav5a4bybc0a1i49";
  };
  pkgs-latest = import nixpkgs-latest {};

  # Custome packages.
  git-tidy-up = pkgs.callPackage ../../packages/git-tidy-up {};

in {

  # Enable bash, disable zsh (the default).
  programs.bash.enable = true;
  programs.zsh.enable = false;  # default shell on catalina

  # Custom home-manager packages.
  imports = [
    ./../../packages/alacritty.nix
    ./../../packages/bash
    ./../../packages/git
    ./../../packages/go-tools
    ./../../packages/htop.nix
    ./../../packages/jetbrains
    ./../../packages/tmux
    ./../../packages/vim
  ];

  # Home-manager default packages.
  home.packages = (with pkgs; [
    autoconf
    bazelisk
    certigo
    cmake
    colordiff
    curl
    dig
    errcheck
    file
    google-cloud-sdk
    gnumake
    gnutar
    git-tidy-up
    go-tools
    golint
    graphviz
    jq
    kubectx
    kubectl
    libtool
    lsof
    nix-prefetch-git
    nodejs
    opensc
    ripgrep
    shellcheck
    openssh
    ssh-agents
    tree
    unzip
    watch
    wget
    which
    whois
    yarn
    yubico-piv-tool
    yubikey-manager
  ]) ++
  # Home-manager packages from a more recent, pinned nixpkgs SHA.
  (with pkgs-latest; [
    awscli2
    go_1_17
  ]) ++
  # Custom packages.
  [
    git-tidy-up
  ];
}
