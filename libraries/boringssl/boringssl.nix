{ config, lib, pkgs, attrsets, ... }:

with lib;

let

  cfg = config.programs.boringssl;
  callPackage = callPackageWith pkgs;

in

{
  options = {
    programs.boringssl = {
      enable = mkEnableOption "boringssl";

      package = mkOption {
        type = types.package;
        default = callPackage ./default.nix {} ;
        defaultText = literalExample "pkgs.boringssl";
        example = literalExample "pkgs.boringssl";
        description = "The boringssl package to install";
      };
    };
  };

  config = mkIf cfg.enable (
    mkMerge ([
      {
        home.packages = [ cfg.package ];
      }
    ])
  );
}
