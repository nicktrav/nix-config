{ pkgs, ... }:

pkgs.writeShellScriptBin "git-tidy-up" (builtins.readFile ./git-tidy-up )
