{ config, pkgs, ... }:

{
  # Enable bash, disable zsh (the default).
  programs.bash.enable = true;
  programs.zsh.enable = false;

  imports = [
    ./common.nix

    # TODO: The Jetbrains packages are very slow on macOS. For now, install
    # manually and manage outside of home-manager.
    #./../../pkgs/jetbrains
  ];

  home.packages = (with pkgs; [
    autoconf
    awscli2
    bazelisk
    cmake
    errcheck
    google-cloud-sdk
    gnumake
    graphviz
    kubectx
    kubectl
    libtool
    openssh
    podman
    tailscale
    yarn
  ]);
}
