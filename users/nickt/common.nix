{ config, pkgs, ... }:

{
  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/direnv.nix
    ./../../pkgs/fzf.nix
    ./../../pkgs/git
    ./../../pkgs/go
    ./../../pkgs/htop.nix
    ./../../pkgs/opensc
    ./../../pkgs/rust
    ./../../pkgs/tmux
    ./../../pkgs/vim
    ./../../pkgs/yubikey
  ];

  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = (with pkgs; [
    certigo
    colordiff
    curl
    dig
    file
    gnutar
    jq
    lsof
    nix-index
    nix-prefetch-git
    patch
    ripgrep
    shellcheck
    ssh-agents
    tree
    unzip
    watch
    wget
    which
    whois
  ]);
}