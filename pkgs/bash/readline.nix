{ config, lib, pkgs, ... }:

{
  programs.readline = {
    enable = true;
    extraConfig = builtins.readFile ./inputrc;
  };
}
