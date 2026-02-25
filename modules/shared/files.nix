{ user, pkgs, config, ... }:

let
  homeDir        = config.users.users.${user}.home;
  xdg_configHome = "${homeDir}/.config";
  xdg_dataHome   = "${homeDir}/.local/share";
  xdg_stateHome  = "${homeDir}/.local/state";

in {
  # Claude Code.
  "${homeDir}/.claude/CLAUDE.md" = {
    text = builtins.readFile ./claude/CLAUDE.md;
  };
  "${homeDir}/.claude/statusline.sh".source = ./claude/statusline.sh;

  # Vim.
  "${xdg_configHome}/nvim/Tomorrow-Night.vim" = {
    text = builtins.readFile ./vim/Tomorrow-Night.vim;
  };

  # Tmux.
  "${xdg_configHome}/tmux/tmux-vim-select-pane".source = ./tmux/tmux-vim-select-pane;

  # Git.
  "${xdg_configHome}/git/.gitconfig".source = ./git/config;
}
