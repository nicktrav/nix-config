# Use the latest version of Tailscale.

(self: super:  {
  tailscale =
    let
      version = "1.16.2";

    in
      # We need at least Go version 1.17 to build more recent versions of
      # Tailscale.
      super.buildGoModule.override { go = super.go_1_17; } {

        # This is a little clunky, but the only way this seems to work is
        # if we inherit all the attrs from the exiting derivation that we
        # don't need to override, and then explicitly set the attributes
        # that we do need to override.
        #
        # Inspiration taken from the following:
        # https://discourse.nixos.org/t/inconsistent-vendoring-in-buildgomodule-when-overriding-source/9225/2

        inherit (super.tailscale.drvAttrs)
          pname nativeBuildInputs CGO_ENABLED
          doCheck subPackages postInstall;
        inherit (super.tailscale) meta;
        inherit version;

        src = super.fetchFromGitHub {
          owner = "tailscale";
          repo = "tailscale";
          rev = "v${version}";
          # nix-prefetch-url https://github.com/tailscale/tailscale/archive/v1.16.2.tar.gz --unpack
          sha256 = "02f6306p2i04kwzsbk958mqfdw5gjk5326iff4vda5p4vlvww9rc";
        };

        # When updating this, set initially to pkgs.lib.fakeSha256 first,
        # then update.
        vendorSha256 = "sha256-HJLT0CGUVzJZ56vS/v3FZ7svxyzZ+wlXvrC2MExTLM4=";

        # This needs to be overridden explicitly as we have updated
        # `version`. Without this, we'll use the `version` from `super`.
        preBuild = ''
          export buildFlagsArray=(
            -tags="xversion"
            -ldflags="-X tailscale.com/version.Long=${version} -X tailscale.com/version.Short=${version}"
          )
        '';
      };
})
