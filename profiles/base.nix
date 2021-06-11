{ pkgs, ... }:

{
  # Enable flakes.

  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # SSH.

  services.openssh.enable = true;

  # TODO: import directly from GitHub.
  users.users.root.openssh.authorizedKeys.keyFiles = [
    ../data/authorized_keys
  ];

  # System packages.

  environment.systemPackages = with pkgs; [
    git
  ];

  # Time.

  time.timeZone = "America/Los_Angeles";
}
