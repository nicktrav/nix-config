# Use a more recent version of Chrome.

(self: super: {
  google-chrome =
    let
      version = "107.0.5304.87";
      channel = "stable";

    in
    super.google-chrome.overrideAttrs (oldAttrs: rec {
      inherit version;
      inherit channel;
      pkgSuffix = if channel == "dev" then "unstable" else
      (if channel == "ungoogled-chromium" then "stable" else channel);
      pkgName = "google-chrome-${pkgSuffix}";
      chromeSrc =
        let
          sha256 = "sha256-QisbBzLtD2nUY4hY1V+Dxlw7h3c7HwMxML262XXERpk=";
        in
        super.fetchurl {
          urls = map (repo: "${repo}/${pkgName}/${pkgName}_${version}-1_amd64.deb") [
            "https://dl.google.com/linux/chrome/deb/pool/main/g"
            "http://95.31.35.30/chrome/pool/main/g"
            "http://mirror.pcbeta.com/google/chrome/deb/pool/main/g"
            "http://repo.fdzh.org/chrome/deb/pool/main/g"
          ];
          inherit sha256;
        };
      src = chromeSrc;
    });
})

