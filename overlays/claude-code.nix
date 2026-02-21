# Override nixpkgs' claude-code with a newer version.
#
# We rebuild the package from scratch rather than using overrideAttrs because
# buildNpmPackage doesn't propagate npmDepsHash changes through overrideAttrs.
# The package-lock.json lives at overlays/pkgs/claude-code/package-lock.json
# and must be updated whenever the version is bumped.
final: prev: {
  claude-code = prev.buildNpmPackage (finalAttrs: {
    pname = "claude-code";
    version = "2.1.50";

    src = prev.fetchzip {
      url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${finalAttrs.version}.tgz";
      hash = "sha256-pSPZzbLhFsE8zwlp+CHB5MqS1gT3CeIlkoAtswmxCZs=";
    };

    npmDepsHash = "sha256-/oQxdQjMVS8r7e1DUPEjhWOLOD/hhVCx8gjEWb3ipZQ=";

    strictDeps = true;

    postPatch = ''
      cp ${../overlays/pkgs/claude-code/package-lock.json} package-lock.json
      substituteInPlace cli.js \
        --replace-fail '#!/bin/sh' '#!/usr/bin/env sh'
    '';

    dontNpmBuild = true;

    env.AUTHORIZED = "1";

    postInstall = ''
      wrapProgram $out/bin/claude \
        --set DISABLE_AUTOUPDATER 1 \
        --set DISABLE_INSTALLATION_CHECKS 1 \
        --unset DEV \
        --prefix PATH : ${prev.lib.makeBinPath [ prev.procps ]}
    '';

    meta = {
      description = "Agentic coding tool";
      homepage = "https://github.com/anthropics/claude-code";
      license = prev.lib.licenses.unfree;
      mainProgram = "claude";
    };
  });
}
