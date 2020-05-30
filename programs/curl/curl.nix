{ config, lib, pkgs, attrsets, ... }:

with lib;

let

  cfg = config.programs.curl;
  callPackage = callPackageWith pkgs;

in

{
  options = {
    programs.curl= {
      enable = mkEnableOption "curl";

      package = mkOption {
        type = types.package;
        default = callPackage ./default.nix {} ;
        defaultText = literalExample "pkgs.curl";
        example = literalExample "pkgs.curl";
        description = "The curl package to install";
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
