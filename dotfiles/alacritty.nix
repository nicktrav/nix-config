{ config, lib, pkgs, attrsets, ... }:

let

in {
  home.file.".config/alacritty/alacritty.yml".source = ~/Development/dotfiles/alacritty/alacritty.yml;
}
