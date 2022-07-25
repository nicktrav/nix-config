{ config, pkgs, ... }:

{
  # Enable bash, disable zsh (the default).
  programs.bash.enable = true;
  programs.zsh.enable = false; # default shell on catalina

  # Custom home-manager packages.
  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/direnv.nix
    ./../../pkgs/fzf.nix
    ./../../pkgs/git
    ./../../pkgs/go
    ./../../pkgs/htop.nix
    ./../../pkgs/rust
    ./../../pkgs/tmux
    ./../../pkgs/vim

    # TODO: The Jetbrains packages are very slow on macOS. For now, install
    # manually and manage outside of home-manager.
    #./../../pkgs/jetbrains
  ];

  # Home-manager default packages.
  home.packages = (with pkgs; [
    autoconf
    awscli2
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
  ]);
}
