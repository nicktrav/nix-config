{ config, lib, pkgs, ... }:

{

  # NOTE: use a custom home-manager version of vim that pulls in nix-darwin.
  # The default vim package doesn't work well with macOS as it is compiled with
  # +xterm_clipboard support, which breaks yanking / copy / paste.
  #
  # See: https://github.com/NixOS/nixpkgs/issues/26726
  # See: https://stackoverflow.com/questions/11404800/fix-vim-tmux-yank-paste-on-unnamed-register

  imports = [ ./custom.nix ];

  programs.vim-darwin = {
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
  };

  xdg.configFile."vim/Tomorrow-Night.vim".text = builtins.readFile ./Tomorrow-Night.vim;
}
