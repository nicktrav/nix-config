{ config, lib, pkgs, ... }:
let
  # TODO: use the upstream version, once it becomes available.
  tmuxline = pkgs.vimUtils.buildVimPlugin {
    name = "tmuxline";
    src = pkgs.fetchFromGitHub {
      owner = "edkolev";
      repo = "tmuxline.vim";
      rev = "4119c553923212cc67f4e135e6f946dc3ec0a4d6";
      sha256 = "0gs2jghs1a9sp09mlphcpa1rzlmxmsvyaa7y20w6qsbczz989vm3";
    };
  };

in {
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      base16-vim
      fzf-vim
      gitgutter
      goyo
      nerdtree
      rust-vim
      syntastic
      tagbar
      #tmuxline
      unite
      vim-airline
      vim-airline-themes
      vim-fugitive
      vim-hcl
      vim-multiple-cursors
      vim-nix
      vim-surround
      vim-tmux
      vim-tmux-focus-events
      vim-tmux-navigator
      vim-unimpaired
      vimwiki
      vimproc
    ];
    extraConfig = builtins.readFile ./vimrc;
  };

  xdg.configFile."vim/Tomorrow-Night.vim".text =
    builtins.readFile ./Tomorrow-Night.vim;
}
