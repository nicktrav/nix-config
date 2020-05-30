{ pkgs }:

with pkgs;
with darwin.apple_sdk.frameworks;

buildGoModule rec {
  version = "0.1.1";
  name = "yubikey-agent-${version}";

  src = fetchgit {
    url = "https://github.com/FiloSottile/yubikey-agent";
    rev = "v${version}";
    sha256 = "0jalcxrhvn65p11ph07yhh8hl0q5w9aq6xp7b60gnwlyifrzyqvg";
  };

  buildInputs = (if stdenv.isDarwin then [ PCSC ] else []);

  goPackagePath = "filippo.io/yubikey-agent";

  modSha256 = "0hq9j0w3y94sd25vcwhgs4zswpqcw2j6midvdny5lq2sfz7jwv3d";

  buildFlagsArray = [
    "-ldflags=-X main.Version=v${version}"
  ];
}
