{ config, lib, pkgs, attrsets, ... }:

with lib;

let

  cfg = config.programs.yubico-piv-tool;
  callPackage = callPackageWith pkgs;

in

{
  options = {
    programs.yubico-piv-tool = {
      enable = mkEnableOption "yubico-piv-tool";

      package = mkOption {
        type = types.package;
        default = callPackage ./default.nix {} ;
        defaultText = literalExample "pkgs.yubico-piv-tool";
        example = literalExample "pkgs.yubico-piv-tool";
        description = "The yubico-piv-tool package to install";
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
