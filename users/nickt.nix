{ config, pkgs, pkgs-unstable, inputs, ... }:

{
  # TODO: Enable this once I work out why it's locking me out.
  #users.mutableUsers = false;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.nickt = { ... }: {
    _module.args.pkgs-unstable = pkgs-unstable;
    home.stateVersion = "21.05";
    imports = [
      ../home/default.nix
    ];
  };

  users.groups.nickt.gid = 1000;
  users.users.nickt = {
    uid = 1000;
    group = "nickt";
    isNormalUser = true;
    home = "/home/nickt";
    createHome = true;
    extraGroups = [ "wheel" ];
    # TODO: import directly from GitHub.
    openssh.authorizedKeys.keyFiles = [
      ../data/authorized_keys
    ];
  };

  # Passwordless sudo.

  security.sudo.extraRules = [
    {
      users = [ "nickt" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
