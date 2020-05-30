{ config, lib, pkgs, attrsets, ... }:

with lib;

let

  cfg = config.programs.certigo;
  callPackage = callPackageWith pkgs;

in

{
  options = {
    programs.certigo = {
      enable = mkEnableOption "certigo";

      package = mkOption {
        type = types.package;
        default = callPackage ./default.nix {} ;
        defaultText = literalExample "pkgs.certigo";
        example = literalExample "pkgs.certigo";
        description = "The certigo package to install";
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
