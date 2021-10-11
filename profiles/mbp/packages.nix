{ config, pkgs, ... }:

let

  latestSHA = "6ba79a5320e82b139452d49e6620c5ddfc2f02e8";
  nixpkgs-latest = builtins.fetchTarball {
    url = "github.com/NixOS/nixpkgs/archive/${latestSHA}.tar.gz";
    sha256 = "1j9wnawgyfix0jz4c25iz2xm9ygbs6zz87hrqkwf4a0cizxchxr6";
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
    gnumake
    git-tidy-up
    go-tools
    golint
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
    go
  ]) ++
  # Custom packages.
  [
    git-tidy-up
  ];
}
