{ config, lib, pkgs, ... }:

{
  programs.go = {
    enable = true;
    package = pkgs.go_1_18;
    goPath = "go";
    goBin = "go/bin";
  };
  home.packages = with pkgs; [
    delve
    gopls
  ];
}
