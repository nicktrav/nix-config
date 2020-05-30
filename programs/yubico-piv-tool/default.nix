{ pkgs }:

with pkgs;
with darwin.apple_sdk.frameworks;

yubico-piv-tool.overrideAttrs ( old: rec {
  version = "2.0.0";
  name = "yubico-piv-tool-${version}";

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl check ]
    ++ (if stdenv.isDarwin then [ PCSC ] else [ pcsclite ]);

  configureFlags = [ "--with-backend=${if stdenv.isDarwin then "macscard" else "pcsc"}" ];

  src = fetchurl {
    url = "https://developers.yubico.com/yubico-piv-tool/Releases/${name}.tar.gz";
    sha256 = "124lhlim05gw32ydjh1yawqbnx6wdllz1ir9j00j09wji3m11rfs";
  };
})
