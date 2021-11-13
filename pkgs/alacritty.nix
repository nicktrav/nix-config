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
        antialias = true;
        normal = {
          family = "Inconsolata-dz for Powerline";
        };
        size = 6.0;
      };
      live_config_reload = true;
      window = {
        decorations = "none";
        padding = {
          x = 2;
          y = 2;
        };
        startup_mode = "Maximized";
      };
      key_bindings = [
        {
          key = "Minus";
          mods = "Super";
          action = "None";
        }
        {
          key = "Backslash";
          mods = "Super";
          action = "None";
        }
      ];
    };
  };
}
