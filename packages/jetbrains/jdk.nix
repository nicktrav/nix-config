{
  lib, pkgs, fetchFromGitHub,
  autoconf, automake, clang, cups, file,
  python39Packages, unzip, which, xcodebuild, zip
}:

with lib;

let
  callPackage = callPackageWith pkgs;

  jdk = callPackage ../openjdk {};

  xattr = python39Packages.xattr;

in

  jdk.overrideAttrs (oldAttrs: rec {
    pname = "jetbrains-jdk";
    version = "11_0_11-b1504.13";
    src = fetchFromGitHub {
      owner = "JetBrains";
      repo = "JetBrainsRuntime";
      rev = "jb${version}";
      sha256 = "1xpgsgmmj5jp5qyw98hqmik6a7z3hfwmij023ij3qqymyj3nhm2i";
    };
    patches = [];
    meta = with lib; {
      description = "An OpenJDK fork to better support Jetbrains's products.";
      longDescription = ''
       JetBrains Runtime is a runtime environment for running IntelliJ Platform
       based products on Windows, Mac OS X, and Linux. JetBrains Runtime is
       based on OpenJDK project with some modifications. These modifications
       include: Subpixel Anti-Aliasing, enhanced font rendering on Linux, HiDPI
       support, ligatures, some fixes for native crashes not presented in
       official build, and other small enhancements.

       JetBrains Runtime is not a certified build of OpenJDK. Please, use at
       your own risk.
      '';
      homepage = "https://confluence.jetbrains.com/display/JBR/JetBrains+Runtime";
      inherit (jdk.meta) license platforms mainProgram;
      maintainers = with maintainers; [ edwtjo petabyteboy ];
    };
    passthru = oldAttrs.passthru // {
      home = "${jdk}/lib/openjdk";
    };

    nativeBuildInputs = [
      autoconf automake cups clang file
      jdk unzip which xattr xcodebuild zip
    ];
    configurePhase = ''
      export PATH=$PATH:/usr/bin/
      ./configure \
        --prefix=$out \
        --with-sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX11.3.sdk/ \
        --disable-warnings-as-errors
    '';
  })
