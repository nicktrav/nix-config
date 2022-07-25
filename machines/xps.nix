{ pkgs, nixgl, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.nickt = import ../users/nickt/home-manager-xps.nix;
  };

  users.users.nickt = {
    isNormalUser = true;
    home = "/home/nickt";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.bash;
    hashedPassword = "$6$A4Qj3zATN$p1dfabtmVJa9aE02Px1tsufmeS1TP3AE6LU6V/36mqvHVW1gtvQl0Li8D8tdVW9G0rP1P7M4CN7hdG7CgfsFY1";
    openssh.authorizedKeys.keyFiles = [
      ../users/nickt/authorized_keys
    ];
  };
}
