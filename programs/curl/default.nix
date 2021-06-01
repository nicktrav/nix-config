{ pkgs, boringssl }:

with pkgs;

curl.overrideAttrs ( old: rec {
  name = "curl-7.72.0";

  src = fetchurl {
    urls = [
      "https://curl.haxx.se/download/${name}.tar.bz2"
      "https://github.com/curl/curl/releases/download/${lib.replaceStrings ["."] ["_"] name}/${name}.tar.bz2"
    ];
    sha256 = "1vq3ay87vayfrv67l7s7h79nm7gwdqhidki0brv5jahhch49g4dd";
  };

  # Compile against boringssl
  #configureFlags = old.configureFlags ++ ["--with-ssl=${boringssl.out}"];
})
