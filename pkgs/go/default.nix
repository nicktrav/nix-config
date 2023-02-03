{ config, lib, pkgs, ... }:

{
  programs.go = {
    enable = true;
    package = pkgs.go_1_20;
    goPath = "go";
    goBin = "go/bin";
  };
  home.packages = with pkgs; [
    delve
    go-tools
    golint
    gopls
  ];
}
