{ pkgs, pkgs-unstable, ... }: {
  imports = [
    ./alacritty.nix
    ./bash
    ./firefox.nix
    ./git.nix
    ./htop.nix
    ./jetbrains.nix ./tmux
    ./vim
  ];

  home.packages = (with pkgs; [
    certigo
    curl
    dig
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
  ]) ++ (with pkgs-unstable; [
    go
  ]);
}
