{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    tmuxPlugins.vim-tmux-navigator
  ];

  programs.tmux = {
    enable = true;
  };

  xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  xdg.configFile."tmux/tmux-vim-select-pane".source = ./tmux-vim-select-pane;
}
