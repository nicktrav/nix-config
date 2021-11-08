{ pkgs, pkgs-unstable, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      google-chrome = pkgs-unstable.google-chrome;
    })
  ];

  home.packages = with pkgs; [
    google-chrome
  ];
}
