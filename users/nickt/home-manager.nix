{ pkgs, pkconfig, ... }:

let
  nixgl = import <nixgl> { };

  nixpkgs-latest = pkgs.fetchgit {
    url = https://github.com/NixOS/nixpkgs;
    rev = "33eaead204bfefea8eee256af6a678adc0906568"; # release-22.05
    sha256 = "sha256-1HW3OPl9NHCbsTQEoSdTvM4YZTmTu9aAc51dBIMOkzk=";
  };
  pkgs-unstable = import nixpkgs-latest { };

in
{

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
  home.stateVersion = "21.11";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nickt";
  home.homeDirectory = "/home/nickt";

  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/dict.nix
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
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = (with pkgs; [
    bat
    binutils
    ccache
    certigo
    colordiff
    curl
    delve
    dig
    file
    firefox
    #gcc
    gnome3.gnome-tweaks
    gnumake
    google-cloud-sdk
    inconsolata
    jq
    lsof
    #nixgl.auto.nixGLDefault
    nixgl.nixGLIntel
    nix-prefetch-git
    nix-index
    nodejs
    openjdk
    #opensc
    #openssh
    patchelf
    powerline-fonts
    pprof
    python2
    nix-index
    nodejs
    nodePackages.bash-language-server
    nodePackages.node-gyp
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
    yarn
    yubico-piv-tool
    yubikey-manager
    yubioath-desktop
  ]) ++ (with pkgs-unstable; [
    _1password
    _1password-gui
    go_1_18
    go-tools
    golint
    google-chrome
    gopls
  ]);

  news.display = "silent";
}
