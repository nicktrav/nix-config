{ pkgs, nixpkgs-unstable, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.nickt = { ... }: {
    _module.args.pkgs-unstable = nixpkgs-unstable;
    home.stateVersion = "21.05";
    imports = [
      ./home-manager.nix
    ];
  };

  users.users.nickt = {
    isNormalUser = true;
    home = "/home/nickt";
    extraGroups = [ "wheel" "docker" "libvirtd" ];
    shell = pkgs.bash;
    hashedPassword = "$6$A4Qj3zATN$p1dfabtmVJa9aE02Px1tsufmeS1TP3AE6LU6V/36mqvHVW1gtvQl0Li8D8tdVW9G0rP1P7M4CN7hdG7CgfsFY1";
    openssh.authorizedKeys.keyFiles = [
      ./authorized_keys
    ];
  };
}
