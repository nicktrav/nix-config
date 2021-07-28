{ config, pkgs, ... }:

{

  # Enable bash, disable zsh (the default).
  programs.bash.enable = true;
  programs.zsh.enable = false;  # default shell on catalina

  # Home-manager default packages.

  home.packages = (with pkgs; [
    certigo
    curl
    dig
    go
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
    whois
    yubico-piv-tool
    yubikey-manager
  ]);

  # Custom packages.

  imports = [
    ./../../packages/alacritty.nix
    ./../../packages/bash
    ./../../packages/git.nix
    ./../../packages/tmux
    ./../../packages/vim
  ];
}
