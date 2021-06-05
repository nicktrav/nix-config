{ config, lib, pkgs, ... }:

{
  imports = [
    ./readline.nix
  ];

  programs.bash = {
    enable = true;
    bashrcExtra =
      builtins.readFile ./bashrc
      + builtins.readFile ./aliases
      + builtins.readFile ./prompt;
    };
}
