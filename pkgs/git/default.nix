{ pkgs, ... }:

let
  git-tidy-up = pkgs.writeShellScriptBin "git-tidy-up" (builtins.readFile ./git-tidy-up );

in {

  programs.git = {
    enable = true;
  };

  home.packages = [
    git-tidy-up
  ];
}
