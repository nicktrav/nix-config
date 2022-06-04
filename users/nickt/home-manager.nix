{ pkgs, ... }:

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
    _1password
    _1password-gui
    bat
    binutils
    certigo
    curl
    delve
    dig
    file
    go_1_18
    google-chrome
    gopls
    jq
    libstdcxx5
    lsof
    nix-prefetch-git
    nodejs
    opensc
    ripgrep
    rnix-lsp
    rust-analyzer
    rustup
    rsync
    shellcheck
    ssh-agents
    tree
    tree-sitter
    unzip
    usbutils
    whois
    xclip
    yubico-piv-tool
    yubikey-manager
    yubioath-desktop
  ]);
}
