user:
{ ...}: {
  imports = [
    ./alacritty.nix
    (import ./git.nix user)
    ./programs.nix
    ./tmux
    ./vim
  ];
}
