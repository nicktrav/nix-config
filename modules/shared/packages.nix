{ pkgs }:

with pkgs; 

let
  git-tidy-up = 
  pkgs.writeShellScriptBin "git-tidy-up" (builtins.readFile ./git/git-tidy-up);

in [
  # Vim
  bat
  nodejs
  nodePackages.bash-language-server
  nil
  nodePackages.node-gyp
  tree-sitter

  # Git
  git-tidy-up
  gh

  # Go.
  delve
  go-tools
  golint
  gopls

  # General tools.
  certigo
  colordiff
  curl
  dig
  file
  gawk
  gnutar
  jq
  lsof
  nix-index
  nix-prefetch-git
  nix-tree
  patch
  ripgrep
  shellcheck
  ssh-agents
  tree
  unzip
  watch
  wget
  which
  whois
]
