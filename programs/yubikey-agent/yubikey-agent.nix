{ config, lib, pkgs, attrsets, ... }:

with lib;

let

  cfg = config.programs.yubikey-agent;
  callPackage = callPackageWith pkgs;

in

{
  options = {
    programs.yubikey-agent = {
      enable = mkEnableOption "yubikey-agent";

      package = mkOption {
        type = types.package;
        default = callPackage ./default.nix {} ;
        defaultText = literalExample "pkgs.yubikey-agent";
        example = literalExample "pkgs.yubikey-agent";
        description = "The yubikey-agent package to install";
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
