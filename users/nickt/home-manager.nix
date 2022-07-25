{ pkgs, ... }:

{
  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/dict.nix
    ./../../pkgs/direnv.nix
    ./../../pkgs/fzf.nix
    ./../../pkgs/git
    ./../../pkgs/go
    ./../../pkgs/gpg
    ./../../pkgs/htop.nix
    ./../../pkgs/i3
    ./../../pkgs/jetbrains
    ./../../pkgs/opensc
    ./../../pkgs/rust
    ./../../pkgs/tmux
    ./../../pkgs/vim
    ./../../pkgs/x
    ./wallpaper.nix
  ];

  xdg.enable = true;

  home.packages = (with pkgs; [
    _1password
    _1password-gui
    binutils
    certigo
    curl
    dig
    file
    google-chrome
    jq
    libstdcxx5
    lsof
    nix-prefetch-git
    nodejs
    pinentry
    ripgrep
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
  ]);
}
