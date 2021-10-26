{ pkgs, ... }:

{
  users.users.nickt = {
    isNormalUser = true;
    home = "/home/nickt";
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
    hashedPassword = "$6$A4Qj3zATN$p1dfabtmVJa9aE02Px1tsufmeS1TP3AE6LU6V/36mqvHVW1gtvQl0Li8D8tdVW9G0rP1P7M4CN7hdG7CgfsFY1";
    openssh.authorizedKeys.keyFiles = [
      ./authorized_keys
    ];
  };

  # Create a Development directory.
  system.activationScripts = {
    mnt = {
      text = "if [ ! -d /home/nickt/Development ] ; then mkdir /home/nickt/Development; fi";
      deps = [];
    };
  };
}
