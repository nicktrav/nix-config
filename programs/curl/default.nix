{ pkgs, boringssl }:

with pkgs;

curl.overrideAttrs ( old: rec {
  name = "curl-7.70.0";

  src = fetchurl {
    urls = [
      "https://curl.haxx.se/download/${name}.tar.bz2"
      "https://github.com/curl/curl/releases/download/${lib.replaceStrings ["."] ["_"] name}/${name}.tar.bz2"
    ];
    sha256 = "1l19b2xmzwjl2fqlbv46kwlz1823miaxczyx2a5lz8k7mmigw2x5";
  };

  # Compile against boringssl
  configureFlags = old.configureFlags ++ ["--with-ssl=${boringssl.out}"];
})

