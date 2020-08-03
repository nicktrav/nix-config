{ pkgs, boringssl }:

with pkgs;

curl.overrideAttrs ( old: rec {
  name = "curl-7.69.1";

  src = fetchurl {
    urls = [
      "https://curl.haxx.se/download/${name}.tar.bz2"
      "https://github.com/curl/curl/releases/download/${lib.replaceStrings ["."] ["_"] name}/${name}.tar.bz2"
    ];
    sha256 = "1s2ddjjif1wkp69vx25nzxklhimgqzaazfzliyl6mpvsa2yybx9g";
  };

  # Compile against boringssl
  configureFlags = old.configureFlags ++ ["--with-ssl=${boringssl.out}"];
})
