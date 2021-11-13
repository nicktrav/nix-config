{ config, pkgs, ... }:

{
  xsession.pointerCursor = {
    package = pkgs.gnome-breeze;
    name = "Breeze-gtk";
    size = 16;
  };
}
