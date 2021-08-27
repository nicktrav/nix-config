# NOTE: fall back to a version of staticcheck that supports the
# -unused.whole-program, which is required by the lint checks in
# cockroachdb/cockroach.

{ pkgs, lib, buildGoModule, fetchFromGitHub, ... }:

let

in {
  nixpkgs.overlays = [
    (self: super: {
      go-tools = pkgs.buildGoModule rec {
        pname = "go-tools";
        version = "2020.1.6";

        src = pkgs.fetchFromGitHub {
          owner = "dominikh";
          repo = "go-tools";
          rev = version;
          sha256 = "1r83gx7k4fiz3wlshhniz1i39xv492nni1nvfxjfqgnmkavb6r4x";
        };

        vendorSha256 = "1g04rzirjv90s1i542cqi2abhgh8b74qwhp1hp1cszgb7k8nndmr";

        doCheck = false;

        meta = with lib; {
          description = "A collection of tools and libraries for working with Go code, including linters and static analysis";
          homepage = "https://staticcheck.io";
          license = licenses.mit;
          maintainers = with maintainers; [ rvolosatovs kalbasit ];
        };
      };
    })
  ];

  home.packages = (with pkgs; [
    go-tools
  ]);
}
