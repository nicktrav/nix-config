user:
{ ...}: {
  imports = [
    ./alacritty.nix
    ./bash
    (import ./git.nix user)
    ./htop.nix
    ./programs.nix
    ./tmux
    ./vim
  ];
}
