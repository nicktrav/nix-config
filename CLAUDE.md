# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

# nix-config

This is a repo of Nix configuration. Think of it as my dotfiles. Where possible
I try to check in _everything_ about my development setup into this repo, so
it's portable, and I can bootstrap a new development machine quickly.

## Keep It Simple, Stupid!

Nix can get incredibly unwieldy. There are a million different ways to do
things. Where possible, prefer the simplest approach possible. Don't go crazy
with the functional programming. We don't need to be cute here.

## Leave A Documentation Paper Trail

I'll likely never recall why it was we did something the way it is unless
there's documentation that explains the reasoning. Where possible, leave
documentation in-line for the more complicated pieces of configuration. No need
to document _everything_ - a lot of things will be obvious. However, if
something _feels_ even slightly complicated or off the beaten path, document
it.

## Repository Structure

```
.
├── flake.nix              # Entry point - defines inputs, outputs, and system configs
├── flake.lock             # Locked dependency versions
├── hosts/
│   ├── darwin/            # macOS system-level config (nix-darwin)
│   └── nixos/             # NixOS system-level config
├── modules/
│   ├── shared/            # Config shared across both platforms (git, bash, vim, tmux, packages)
│   ├── darwin/            # macOS-specific modules (dock, casks, packages)
│   └── nixos/             # NixOS-specific modules (disk, packages)
├── overlays/              # Package overrides, version pins, patches
└── apps/                  # Build/deploy shell scripts, per architecture
    ├── aarch64-darwin/
    ├── x86_64-darwin/
    ├── aarch64-linux/
    └── x86_64-linux/
```

## How Configuration Composes

`flake.nix` is the entry point. It defines two main output types:

- `darwinConfigurations` → `hosts/darwin/default.nix` → imports from `modules/darwin/` and `modules/shared/`
- `nixosConfigurations` → `hosts/nixos/default.nix` → imports from `modules/nixos/` and `modules/shared/`

Packages are split across three files:
- `modules/shared/packages.nix` — installed on both platforms
- `modules/darwin/packages.nix` — macOS only (imports shared, then adds more)
- `modules/nixos/packages.nix` — NixOS only (imports shared, then adds more)

Home-manager config follows the same pattern:
- `modules/shared/home-manager.nix` — shared program configs (git, bash, neovim, etc.)
- `modules/darwin/home-manager.nix` and `modules/nixos/home-manager.nix` — platform-specific

## Building and Testing

The current machine is macOS on Apple Silicon (aarch64-darwin).

Build without switching (validation only):

    nix run .#build

Build and switch to the new generation:

    nix run .#build-switch

Rollback to the previous generation:

    nix run .#rollback

These are wrappers around scripts in `apps/aarch64-darwin/`. Use them instead
of running `darwin-rebuild` or `nixos-rebuild` directly — the scripts handle
SSL cert workarounds and cleanup.

## Common Tasks

- **Add a package for both platforms:** add to `modules/shared/packages.nix`
- **Add a macOS-only package:** add to `modules/darwin/packages.nix`
- **Add a Homebrew cask:** add to `modules/darwin/casks.nix`
- **Add/change a program config (git, vim, tmux, bash):** edit `modules/shared/home-manager.nix`
- **Pin or override a package version:** add an overlay file in `overlays/`
- **Change macOS system defaults (keyboard, trackpad, dock, etc.):** edit `hosts/darwin/default.nix`

## Conventions

- The primary user is `nickt` — hardcoded in `flake.nix` and referenced throughout.
- nixpkgs tracks the `nixpkgs-25.05-darwin` branch. nix-darwin tracks `nix-darwin-25.05`.
- `allowUnfree` and `allowBroken` are both `true` (set in `modules/shared/default.nix`).
- Overlays in `overlays/` are automatically applied to every build. Don't put
  anything there that shouldn't run on every rebuild.
- Shell config files (bashrc, aliases, inputrc, etc.) live as plain text files
  under `modules/shared/bash/` and are read into Nix via `builtins.readFile`.
  Edit those files directly rather than writing Nix expressions for shell config.
- The same pattern applies to vim, tmux, and git configs — look for plain text
  files under `modules/shared/` before trying to write Nix.
- Nix uses the Determinate Systems daemon, not the default Nix daemon.
