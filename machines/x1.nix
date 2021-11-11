{ config, pkgs, ... }:

{
  imports = [
    ./shared.nix
  ];

  # Use a more recent Linux kernel.
  boot.kernelPackages = pkgs.linuxPackages_5_14;

  # Enable host-specific interfaces.
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.enp45s0u2.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Tailscale networking.
  nixpkgs.overlays = [
    (import ../overlays/tailscale.nix)
  ];
  environment.systemPackages = with pkgs; [
    tailscale
  ];
  services.tailscale.enable = true;

  # Firewall.
  networking.firewall = {
    enable = true;
    interfaces = {
      "enp45s0u2" = {
        allowedTCPPorts = [ 22 ];
      };
      "tailscale0" = {
        allowedTCPPorts = [ 22 ];
        allowedUDPPorts = [ config.services.tailscale.port ];
      };
      "wlp0s20f3" = {
        allowedTCPPorts = [ 22 ];
      };
    };
  };

  # Remain open with the lid closed.
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
  };
}
