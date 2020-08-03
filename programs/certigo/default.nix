{ pkgs }:

with pkgs;

certigo.overrideAttrs ( old: rec {
  version = "1.12.1";

  src = fetchFromGitHub {
    owner = "square";
    repo = old.pname;
    rev = "v${version}";
    sha256 = "0siwbxxzknmbsjy23d0lvh591ngabqhr2g8mip0siwa7c1y7ivv4";
  };

  patches = [
    (fetchurl {
      # Verion fix.
      url = https://github.com/square/certigo/commit/cea08b4292261c9635567defdeba3d309f744118.patch;
      sha256 = "0x79l32f6qxks4zhr3yq60416afq7k4lrf4ia9hl200hwlzm74p6";
    })
  ];

  goPackagePath = "github.com/square/certigo";
})
