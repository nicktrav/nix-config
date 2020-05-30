{ config, lib, pkgs, attrsets, ... }:

with lib;

let

  cfg = config.programs.vim;

in

{
  config = {
    home.file.".vimrc".source = ./configs/.vimrc;
  };
}
