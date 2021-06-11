{ config, pkgs, ... }:

{

  # User setup.

  # TODO: Enable this once I work out why it's locking me out.
  #users.mutableUsers = false;

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
      ./authorized_keys
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
