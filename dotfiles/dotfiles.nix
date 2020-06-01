{ config, lib, pkgs, attrsets, ... }:

let

in {
  home.file.".config/alacritty/alacritty.yml".source = ~/Development/dotfiles/alacritty/alacritty.yml;
  home.file.".bashrc".source = ~/Development/dotfiles/.bash_profile;
  home.file.".bash_profile".source = ./.bash_profile;
  home.file.".bash_prompt".source = ~/Development/dotfiles/.bash_prompt;
}
