{ config, pkgs, ... }:

{
  home.pointerCursor = {
    package = pkgs.libsForQt5.breeze-gtk;
    name = "Breeze-gtk";
    size = 16;
  };
}
