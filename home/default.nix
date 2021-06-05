user:
{ ...}: {
  imports = [
    (import ./git.nix user)
    ./programs.nix
    ./tmux
    ./vim
  ];
}
