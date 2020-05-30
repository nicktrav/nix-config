{ pkgs }:

with pkgs;

go.overrideAttrs ( old: rec {
  version = "1.14.3";

  src = fetchurl {
    url = "https://dl.google.com/go/go${version}.src.tar.gz";
    sha256 = "0mmgf74snprdiajgh99jjliwjl5im71qcgm5qrxpnyfisiw3f0lk";
  };
})

