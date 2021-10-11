{ config, ... }:

{
  xdg.configFile."git/.gitconfig".source = ./.gitconfig;

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
}
