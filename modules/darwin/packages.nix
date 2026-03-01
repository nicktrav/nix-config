{ pkgs }:

with pkgs;

let 
  shared-packages = import ../shared/packages.nix { inherit pkgs; };

in
  shared-packages ++ [
    autoconf
    awscli2
    bazelisk
    claude-code
    cmake
    code-cursor
    cursor-agent
    errcheck
    google-cloud-sdk
    gnumake
    graphviz
    kubectx
    kubectl
    libtool
    openssh
    pnpm
    podman
    tailscale
    yarn
    yubikey-manager
]
