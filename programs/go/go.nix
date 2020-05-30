{ config, lib, pkgs, attrsets, ... }:

with lib;

let
  callPackage = callPackageWith pkgs;

in {
  programs.go = {
    package = callPackage ./default.nix { };
  };
}
