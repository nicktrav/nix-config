{ nixgl-pkgs, ... }:

{
  imports = [
    ./../../pkgs/alacritty.nix
    ./../../pkgs/bash
    ./../../pkgs/dict.nix
    ./../../pkgs/direnv.nix
    ./../../pkgs/fzf.nix
    ./../../pkgs/git
    ./../../pkgs/go
    ./../../pkgs/htop.nix
    ./../../pkgs/jetbrains
    ./../../pkgs/rust
    ./../../pkgs/tmux
    ./../../pkgs/vim
    ./../../pkgs/x
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = (with nixgl-pkgs; [
    _1password
    _1password-gui
    bat
    bazelisk
    binutils
    ccache
    certigo
    colordiff
    curl
    dig
    file
    firefox
    gnome3.gnome-tweaks
    gnumake
    go-tools
    golint
    google-chrome
    google-cloud-sdk
    inconsolata
    jq
    lsof
    nixgl.nixGLIntel
    nix-prefetch-git
    nix-index
    nodejs
    openjdk
    patchelf
    powerline-fonts
    pprof
    python2
    nix-index
    nodejs
    nodePackages.bash-language-server
    nodePackages.node-gyp
    openjdk
    patchelf
    powerline-fonts
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
  ]);

  news.display = "silent";
}
