{ config, pkgs, ... }:

let

  latestSHA = "91cd6f62079ada68bdd9a45fbbf181522bf51e44";
  nixpkgs-latest = builtins.fetchTarball {
    url = "github.com/NixOS/nixpkgs/archive/${latestSHA}.tar.gz";
    sha256 = "03sn3fhlxj7mkr6zz3r6irf0gs8rz88ypi0rx6adn9kj9wrgigzz";
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
