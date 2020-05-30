{ pkgs }:

with pkgs;

buildGoModule rec {
  pname = "certigo";
  version = "1.12.1";

  src = fetchFromGitHub {
    owner = "square";
    repo = pname;
    rev = "v${version}";
    sha256 = "0siwbxxzknmbsjy23d0lvh591ngabqhr2g8mip0siwa7c1y7ivv4";
  };

  goPackagePath = "github.com/square/certigo";

  modSha256 = "1i5n5yh6nvv2i2nm60vqy1gngj8p5w6ma5fcwmp7bl4jxjrzbi83";

  patches = [
    (fetchurl {
      # Verion fix.
      url = https://github.com/square/certigo/commit/cea08b4292261c9635567defdeba3d309f744118.patch;
      sha256 = "0x79l32f6qxks4zhr3yq60416afq7k4lrf4ia9hl200hwlzm74p6";
    })
  ];

  meta = with stdenv.lib; {
    description = "A utility to examine and validate certificates in a variety of formats";
    homepage = "https://github.com/square/certigo";
    license = licenses.asl20;
    maintainers = [ maintainers.marsam ];
  };
}
