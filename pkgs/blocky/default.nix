{ config, lib, pkgs, ... }:

let
  cfg = config.services.blocky-dns;

in with lib; {
  options.services.blocky-dns = {
    enable = mkEnableOption "Enable blocky service";

    package = mkOption {
      type = types.package;
      default = pkgs.blocky;
      defaultText = "pkgs.blocky";
      description = "Blocky package to use.";
    };

    configFile = mkOption {
      type = types.path;
      description = "Path to Blocky's configuration file";
      default = ./config.yaml;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.services.blocky = {
      description = "Blocky server daemon.";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      restartIfChanged = true;
      serviceConfig = {
        User="root";
        ExecStart = "${cfg.package}/bin/blocky --config ${cfg.configFile}";
        Restart = "always";
      };
    };
  };

  meta.maintainers = with lib.maintainers; [  ];
}
