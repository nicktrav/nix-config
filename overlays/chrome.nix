# Use a more recent version of Chrome.

(self: super: {
  google-chrome =
    let
      version = "106.0.5249.103";
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
          sha256 = "sha256-vbh/3YD1GADhZ0ttaoWmQy86hYBI2hMojkfBsV1q5i0=";
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

