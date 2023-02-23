{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ../../pkgs/blocky
  ];

  xdg.enable = true;

  home.packages = (with pkgs; [
  ]);
}
