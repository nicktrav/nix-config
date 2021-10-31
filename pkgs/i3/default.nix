{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi
  ];

  xdg.configFile."i3/config".text = builtins.readFile ./i3;
  xdg.configFile."rofi/config.rasi".text = builtins.readFile ./rofi;
}
