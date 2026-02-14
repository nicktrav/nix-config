# overlays/cursor-agent.nix
final: prev: {
  cursor-agent = prev.callPackage ./pkgs/cursor-agent { };
}
