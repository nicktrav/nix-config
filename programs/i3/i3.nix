{ config, lib, pkgs, attrsets, ... }:

with lib;

{
  config = {
    home.file.".config/i3/source".source = ./config;
  };
}
