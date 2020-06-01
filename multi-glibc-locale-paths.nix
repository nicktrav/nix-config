# Based on https://gist.github.com/peti/2c818d6cb49b0b0f2fd7c300f8386bc3

{ config, pkgs, ... }:

/*
 * Provide version-specific LOCALE_ARCHIVE environment variables to mitigate
 * the effects of https://github.com/NixOS/nixpkgs/issues/38991.
 */

let

  # A random Nixpkgs revision *before* the default glibc
  # was switched to version 2.27.x.
  oldpkgsSrc = pkgs.fetchFromGitHub {
    owner = "nixos";
    repo = "nixpkgs";
    rev = "0252e6ca31c98182e841df494e6c9c4fb022c676";
    sha256 = "1sr5a11sb26rgs1hmlwv5bxynw2pl5w4h5ic0qv3p2ppcpmxwykz";
  };

  oldpkgs = import oldpkgsSrc {};

in

{
  home.sessionVariables = {
    LOCALE_ARCHIVE_2_11 = "${oldpkgs.glibcLocales}/lib/locale/locale-archive";
    LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  };
}
