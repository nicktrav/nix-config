{ pkgs, pkgs-unstable, config, ... }:

let
  git-tidy-up = pkgs.writeShellScriptBin "git-tidy-up" (builtins.readFile ./git-tidy-up);

in
{
  programs.git = {
    package = pkgs-unstable.git;
    enable = true;
    includes = [
      { path = "~/.config/git/.gitconfig"; }
    ];
    ignores = [
      ".direnv/"
      ".envrc"
      ".idea/"
      ".ijwb/"
      "*.swn"
      "*.swo"
      "*.swp"
      "shell.nix"
    ];
  };

  home.packages = [
    git-tidy-up
  ];

  xdg.configFile."git/.gitconfig".source = ./.gitconfig;
}
