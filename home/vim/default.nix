{ config, lib, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
  };
  xdg.configFile."vim/Tomorrow-Night.vim".text = builtins.readFile ./Tomorrow-Night.vim;
}
