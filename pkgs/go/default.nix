{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    delve
    go_1_18
    gopls
  ];
}
