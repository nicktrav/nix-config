{ config, lib, pkgs, attrsets, ... }:

with lib;

let
  callPackage = callPackageWith pkgs;

in {
  nixpkgs.overlays = [
    (self: super: {
      alacritty = callPackage ./default.nix { };
    })
  ];

  programs.alacritty = {
    settings = import ./config.nix;
  };
}
