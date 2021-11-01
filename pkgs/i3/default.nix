{ config, lib, pkgs, ... }:

let
  polybar = pkgs.polybar.override {
    i3Support = true;
  };

in {
  home.packages = with pkgs; [
    polybar
    rofi
  ];

  xdg.configFile."i3/config".text = builtins.readFile ./i3;
  xdg.configFile."rofi/config.rasi".text = builtins.readFile ./rofi;
  xdg.configFile."polybar/config".text = builtins.readFile ./polybar;
  xdg.configFile."polybar/launch.sh".source = ./polybar-launch.sh;
}
