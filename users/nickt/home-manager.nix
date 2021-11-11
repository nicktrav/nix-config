{ pkgs, config, ... }:

let

  # Pull in the lastet from the main branch, in case we need a version of
  # something more "bleeding edge".
  nixpkgsRev_latest = "00021b8642c065a4da8a8d947211b431e1b52e8d";
  nixpkgs_latest = builtins.fetchTarball {
    url = "github.com/NixOS/nixpkgs/archive/${nixpkgsRev_latest}.tar.gz";
  };
  pkgs-unstable = import nixpkgs_latest { };

  nixglRev = "c4aa5aa15af5d75e2f614a70063a2d341e8e3461";
  nixgl = import (builtins.fetchTarball {
    url = "github.com/guibou/nixGL/archive/${nixglRev}.tar.gz";
  }) { };

in {

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nickt";
  home.homeDirectory = "/home/nickt";

  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/direnv.nix
    (import ./../../pkgs/chrome { inherit pkgs pkgs-unstable; })
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
  xdg.mime.enable=true;
  targets.genericLinux.enable=true;

  fonts.fontconfig.enable = true;

  home.packages = (with pkgs; [
    binutils
    certigo
    curl
    dig
    file
    firefox
    gcc
    gnome3.gnome-tweaks
    gnumake
    inconsolata
    jq
    lsof
    nixgl.nixGLIntel
    nix-prefetch-git
    nix-index
    nodejs
    openjdk
    #opensc
    #openssh
    patchelf
    powerline-fonts
    nix-index
    nodejs
    openjdk
    #opensc
    #openssh
    patchelf
    powerline-fonts
    #opensc
    #openssh
    patchelf
    powerline-fonts
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
  ]) ++ (with pkgs-unstable; [
    _1password
    _1password-gui
    go
    go-tools
    golint
    google-chrome
  ]);

  news.display = "silent";
}
