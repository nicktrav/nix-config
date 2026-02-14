# pkgs/cursor-agent/default.nix
{ lib, stdenvNoCC, fetchurl, makeWrapper, nodejs, ripgrep, pkgs }:

stdenvNoCC.mkDerivation rec {
  pname = "cursor-agent";
  version = "2026.01.02-80e4d9b";

  src = fetchurl {
    url = "https://downloads.cursor.com/lab/${version}/darwin/arm64/agent-cli-package.tar.gz";
    sha256 = "0g84ad4mycwcg7h3mpqjkrkk836hbx7icqx6k4f14lapcdyxlb87";
  };

  nativeBuildInputs = [ makeWrapper ];

  unpackPhase = "tar -xzf $src";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin

    # Put everything the launcher expects right beside it. We don't need to
    # copy over the node and rg binaries. Those we can make available further
    # below.
    cp -a dist-package/cursor-agent $out/bin/
    cp -a dist-package/index.js $out/bin/
    cp -a dist-package/package.json $out/bin/
    cp -a dist-package/*.node $out/bin/

    # Ensure executables are marked executable.
    chmod +x $out/bin/cursor-agent || true

    # Don't install the bundled node binary — it conflicts with nixpkgs'
    # nodejs in the home-manager environment. cursor-agent gets node via
    # the PATH wrapper below instead.
    wrapProgram $out/bin/cursor-agent \
      --prefix PATH : ${lib.makeBinPath [ nodejs ripgrep ]}
    runHook postInstall
  '';

  meta = with lib; {
    description = "Cursor Agent CLI";
    license = licenses.unfree;
    platforms = platforms.darwin;
  };
}
