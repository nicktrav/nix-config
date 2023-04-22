{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  xdg.enable = true;

  home.packages = (with pkgs; [
  ]);
}
