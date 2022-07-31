(self: super: {
  jetbrains =
    super.jetbrains.overrideAttrs (oldAttrs: rec {
      vmopts = ''
        -Xms8g
        -Xmx8g
      '';
    });
})
