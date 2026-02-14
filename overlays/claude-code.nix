# Override nixpkgs' claude-code to a newer npm version.
final: prev:
let
  newVersion = "2.1.32";
  newSrc = prev.fetchurl {
    url  = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${newVersion}.tgz";
    hash = "sha256-qMCPsYVxWnn46Hah9Qd+rSN6eOQ/8Qafd35IfHkLAe0=";
  };
in {
  claude-code = prev.claude-code.overrideAttrs (old: {
    version = newVersion;
    src = newSrc;
    npmDepsHash = prev.lib.fakeHash;
  });
}
