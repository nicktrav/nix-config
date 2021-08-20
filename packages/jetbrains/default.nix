# NOTE: This is lifted directly from nixpkgs so that we can fork the Goland
# build to allow packaging for x86_64-darwin via an overlay. We also wire up a
# custom JDK.
#
# See here for the original:
# https://github.com/NixOS/nixpkgs/blob/21.05/pkgs/applications/editors/jetbrains/default.nix

{ config, pkgs, lib, ... }:

with lib;

let

  config.jetbrains.vmopts = builtins.readFile ./vmoptions;

  vmopts = config.jetbrains.vmopts or null;

  callPackage = callPackageWith pkgs;

  mkJetBrainsProduct = callPackage ./common.nix { inherit vmopts; };

  # TODO(nickt): Update this to use the forked JDK shipped by Jetbrains, by
  # referencing the ./jdk.nix file.
  #
  # The issue with using it is that it looks for the xcodebuild tool, which
  # isn't present in nix.
  #jdk = callPackage ./jdk.nix {};
  jdk = callPackage ../openjdk {};

  buildGoland = { name, version, src, license, description, wmClass, ... }:
    (mkJetBrainsProduct {
      inherit name version src wmClass jdk;
      product = "Goland";
      meta = with lib; {
        homepage = "https://www.jetbrains.com/go/";
        inherit description license;
        longDescription = ''
          Goland is the codename for a new commercial IDE by JetBrains
          aimed at providing an ergonomic environment for Go development.
          The new IDE extends the IntelliJ platform with the coding assistance
          and tool integrations specific for the Go language
        '';
        maintainers = [ maintainers.miltador ];
        platforms = [ "x86_64-darwin" "i686-darwin" "i686-linux" "x86_64-linux" ];
      };
    });

in {
  nixpkgs.overlays = [
    (self: super: {
      jetbrains = super.jetbrains // {
        goland = buildGoland rec {
          name = "goland-${version}";
          version = "2021.1.1"; /* updated by script */
          description = "Up and Coming Go IDE";
          license = lib.licenses.unfree;
          src = pkgs.fetchurl {
            url = "https://download.jetbrains.com/go/${name}.tar.gz";
            sha256 = "02fyrq4px9w34amincgjgm6maxpxn445j5h4nfbskx7z428ynx25"; /* updated by script */
          };
          wmClass = "jetbrains-goland";
          update-channel = "GoLand RELEASE";
        };
      };
    })
  ];
}
