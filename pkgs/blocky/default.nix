{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    blocky
  ];
}
