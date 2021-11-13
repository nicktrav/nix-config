# Use a more recent version of nix-direnv.
# See: https://github.com/nix-community/nix-direnv/issues/114

(self: super:  {
  nix-direnv =
    let
      version = "1.5.0";

    in super.nix-direnv.overrideAttrs (oldAttrs: rec {
      inherit version;
      src = super.fetchFromGitHub {
        owner = "nix-community";
        repo = "nix-direnv";
        rev = version;
        sha256 = "sha256-PEteip6FcaJ2wqdhSM9SqL7bJ4nimcOrC3s2pWunEIE=";
      };
    });
})
