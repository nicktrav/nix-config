{ nixgl-pkgs, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  home.packages = (with pkgs; [
    openssh
  ]);
}
