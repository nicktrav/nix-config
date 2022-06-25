{ config, pkgs, ... }:

let

  nixpkgs-latest = pkgs.fetchgit {
    url = https://github.com/NixOS/nixpkgs;
    rev = "52dc75a4fee3fdbcb792cb6fba009876b912bfe0"; # nixpkgs-unstable
    sha256 = "1mc7qncf38agvyd589akch0war71gx5xwfli9lh046xqsqsbhhl0";
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
    gnupg
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
    patch
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
    go_1_18
  ]) ++
  # Custom packages.
  [
    git-tidy-up
  ];
}
