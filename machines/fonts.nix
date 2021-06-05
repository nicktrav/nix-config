{ config, lib, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      inconsolata
      powerline-fonts
    ];
  };
}
