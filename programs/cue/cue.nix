{ config, lib, pkgs, attrsets, ... }:

with lib;

let

  cfg = config.programs.cue;
  callPackage = callPackageWith pkgs;

in

{
  options = {
    programs.cue= {
      enable = mkEnableOption "cue";

      package = mkOption {
        type = types.package;
        default = callPackage ./default.nix {} ;
        defaultText = literalExample "pkgs.cue";
        example = literalExample "pkgs.cue";
        description = "The cue package to install";
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
