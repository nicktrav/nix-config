user:
{ ...}: {
  imports = [
    ./alacritty.nix
    ./bash
    (import ./git.nix user)
    ./programs.nix
    ./tmux
    ./vim
  ];
}
