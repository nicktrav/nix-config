{ config, pkgs, ... }:

{
  users.groups.nickt.gid = 1000;
  users.users.nickt = {
    uid = 1000;
    group = "nickt";
    isNormalUser = true;
    home = "/home/nickt";
    createHome = true;
    extraGroups = [ "wheel" ];
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
