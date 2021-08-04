{ config, ... }:

{
  xdg.configFile."git/.gitignore_global".source = ./.gitignore_global;

  programs.git = {
    enable = true;
    extraConfig = {
      core = {
        excludesFile = "~/.config/git/.gitignore_global";
      };
    };
  };
}
