let

  nixpkgsRev = "20.09";
  nixpkgs = builtins.fetchTarball {
    url = "github.com/NixOS/nixpkgs/archive/${nixpkgsRev}.tar.gz";
    sha256 ="1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
  };
  pkgs = import nixpkgs { };

  # Pull in the lastet from the main branch, in case we need a version of
  # something more "bleeding edge".
  nixpkgsRev_latest = "57baa7efb78d8eda38ca8955bea1f14e144353b8";
  nixpkgs_latest = builtins.fetchTarball {
    url = "github.com/NixOS/nixpkgs/archive/${nixpkgsRev_latest}.tar.gz";
  };
  pkgs_latest = import nixpkgs_latest { };

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

  programs.boringssl.enable = true;
  programs.certigo.enable = true;
  programs.curl.enable = true;
  programs.yubico-piv-tool.enable = true;

  # TODOs - the following are custom, but aren't yet working.
  #
  #programs.alacritty.enable = true;
  #programs.cue.enable = true;
  #programs.go.enable = true;
  #programs.yubikey-agent.enable = true;

  home.packages = with pkgs; [
    buildifier
    buildozer
    cacert
    colordiff
    dep2nix
    dict
    ffmpeg
    fzf
    git
    gnupg
    grpcurl
    htop
    imagemagick
    inconsolata
    jq
    kazam
    #kops
    kubectx
    loc
    maven
    nerdfonts
    nghttp2
    nix-prefetch-git
    nodejs
    openjdk11
    opensc
    openssh
    packer
    powerline-fonts
    protobuf
    pngquant
    ripgrep
    shellcheck
    slack
    ssh-agents
    tmux
    tree
    unzip
    wget
    whois
    xclip
    xsel
    yarn
    yubikey-manager
    yubioath-desktop

    # Newer versions
    pkgs_latest.go_1_16
    pkgs_latest.google-cloud-sdk
    pkgs_latest.jetbrains.clion
    pkgs_latest.jetbrains.goland
    pkgs_latest.jetbrains.idea-ultimate
    pkgs_latest.kind
    pkgs_latest.kubectl
    #pkgs_latest.pulumi-bin
    pkgs_latest.mkcert
    pkgs_latest.rustup
    pkgs_latest.signal-desktop

    # TODOs - for whatever reason the following aren't working. Instead, apt is
    # used to install them.
    #
    # alacritty
    # vim
    # spotify
  ];

  news.display = "silent";
}
