{ pkgs, config, ... }:

let
  git-tidy-up = pkgs.writeShellScriptBin "git-tidy-up" (builtins.readFile ./git-tidy-up );

in {
  programs.git = {
    enable = true;
    includes = [
      { path = "~/.config/git/.gitconfig"; }
    ];
    ignores = [
      "*.swn"
      "*.swo"
      "*.swp"
      ".idea/"
      ".ijwb/"
    ];
  };

  home.packages = [
    git-tidy-up
  ];

  xdg.configFile."git/.gitconfig".source = ./.gitconfig;
}
