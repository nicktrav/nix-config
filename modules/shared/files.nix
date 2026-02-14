{ user, pkgs, config, ... }:

let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state";

in {
  # Vim.
  "${xdg_configHome}/nvim/Tomorrow-Night.vim" = {
    text = builtins.readFile ./vim/Tomorrow-Night.vim;
  };

  "${xdg_configHome}/nvim/vimspector/configurations/linux/go/config.json" = {
    text = builtins.readFile ./vim/vimspector-go.json;
  };

  # Tmux.
  "${xdg_configHome}/tmux/tmux-vim-select-pane".source = ./tmux/tmux-vim-select-pane;

  # Git.
  "${xdg_configHome}/git/.gitconfig".source = ./git/config;
}
