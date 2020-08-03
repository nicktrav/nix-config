let
  nixpkgsRev = "20.03";
  nixpkgs = builtins.fetchTarball {
    url = "github.com/NixOS/nixpkgs/archive/${nixpkgsRev}.tar.gz";
    sha256 ="0182ys095dfx02vl2a20j1hz92dx3mfgz2a6fhn31bqlp1wa8hlq";
  };
  pkgs = import nixpkgs { };
in
{ config, ... }:

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
  home.stateVersion = "20.03";

  imports = [
    ./libraries/boringssl/boringssl.nix
    ./programs/alacritty/alacritty.nix
    ./programs/certigo/certigo.nix
    ./programs/cue/cue.nix
    ./programs/curl/curl.nix
    ./programs/go/go.nix
    ./programs/vim/vim.nix
    ./programs/yubico-piv-tool/yubico-piv-tool.nix
    ./programs/yubikey-agent/yubikey-agent.nix
  ];

  #programs.alacritty.enable = true;
  programs.boringssl.enable = true;
  programs.certigo.enable = true;
  #programs.cue.enable = true;
  programs.curl.enable = true;
  #programs.go.enable = true;
  programs.yubico-piv-tool.enable = true;
  #programs.yubikey-agent.enable = true;

  home.packages = with pkgs; [
    #alacritty
    fzf
    cargo
    dep2nix
    dict
    ffmpeg
    git
    gnupg
    go
    google-cloud-sdk
    grpcurl
    htop
    inconsolata
    openjdk11
    jetbrains.idea-ultimate
    jetbrains.goland
    jetbrains.clion
    jq
    kazam
    kops
    kubectl
    kubectx
    maven
    opensc
    openssh
    packer
    #pinentry_mac
    powerline-fonts
    protobuf
    nerdfonts
    nghttp2
    nix-prefetch-git
    cacert
    ripgrep
    rustc
    shellcheck
    slack
    ssh-agents
    tmux
    tree
    unzip
    #vim
    wget
    wireshark
    whois
    xclip
    xsel
    yubikey-manager
    yubioath-desktop
  ];

  news.display = "silent";
}
