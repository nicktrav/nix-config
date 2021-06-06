user:
{ ...}: {
  imports = [
    ./alacritty.nix
    ./bash
    ./firefox.nix
    (import ./git.nix user)
    ./htop.nix
    ./programs.nix
    ./tmux
    ./vim
  ];
}
