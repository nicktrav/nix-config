{ pkgs }:

with pkgs;

go.overrideAttrs ( old: rec {
  version = "1.14.6";

  src = fetchurl {
    url = "https://dl.google.com/go/go${version}.src.tar.gz";
    sha256 = "02acr52bxfjlr3m11576gdwn8hjv1pr2pffcis913m0m31w9vz3k";
  };
})

