{ pkgs }:

with pkgs;

boringssl.overrideAttrs ( old: rec {
  version = "chromium-stable-243b5cc9e";
  pname = "boringssl-${version}";

  src = fetchgit {
    url    = "https://boringssl.googlesource.com/boringssl";
    rev    = "243b5cc9e33979ae2afa79eaa4e4c8d59db161d4";
    sha256 = "1ak27dln0zqy2vj4llqsb99g03sk0sg25wlp09b58cymrh3gccvl";
  };

  meta = {
    priority = "0";
  };
})

