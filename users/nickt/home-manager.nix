{ pkgs, pkgs-unstable, ... }:

{
  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/dict.nix
    ./../../pkgs/direnv.nix
    ./../../pkgs/fzf.nix
    ./../../pkgs/git
    ./../../pkgs/htop.nix
    ./../../pkgs/i3
    ./../../pkgs/jetbrains
    ./../../pkgs/tmux
    ./../../pkgs/vim
    ./../../pkgs/x
    ./wallpaper.nix
  ];

  xdg.enable = true;

  home.packages = (with pkgs; [
    bat
    binutils
    certigo
    curl
    delve
    dig
    file
    google-chrome
    jq
    libstdcxx5
    lsof
    nix-prefetch-git
    opensc
    ripgrep
    rnix-lsp
    rust-analyzer
    rustup
    rsync
    shellcheck
    ssh-agents
    tree
    unzip
    usbutils
    whois
    xclip
    yubico-piv-tool
    yubikey-manager
    yubioath-desktop
  ]) ++ (with pkgs-unstable; [
    _1password
    _1password-gui
    go_1_17
    gopls
  ]);
}
