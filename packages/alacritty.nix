{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          foreground = "0xb0bec5";
          background = "0x1b1b1b";
        };
        normal = {
          black   = "0x313129";
          red     = "0x974040";
          green   = "0x7cbf68";
          yellow  = "0xdd6060";
          blue    = "0xff7272";
          magenta = "0xe7a6a6";
          cyan    = "0xc79898";
          white   = "0xf7f7f7";
        };
        bright = {
          black   = "0x708284";
          red     = "0x974040";
          green   = "0x7cbf68";
          yellow  = "0xdd6060";
          blue    = "0xff7272";
          magenta = "0xe7a6a6";
          cyan    = "0xc79898";
          white   = "0xf7f7f7";
        };
      };
      font = {
        size = 13.0;
        antialias = true;
        normal = {
          family = "Inconsolata-dz for Powerline";
        };
      };
      key_bindings = [
        { key = "Up";    mods = "Option"; chars = "\\x1b[1;5A"; }
        { key = "Down";  mods = "Option"; chars = "\\x1b[1;5B"; }
        { key = "Left";  mods = "Option"; chars = "\\x1bb"; }
        { key = "Right"; mods = "Option"; chars = "\\x1bf"; }
      ];
      live_config_reload = true;
      window = {
        decorations = "none";
        padding = {
          x = 2;
          y = 2;
        };
        startup_mode = "Maximized";
      };
    };
  };
}
