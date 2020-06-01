{ config, lib, pkgs, attrsets, ... }:

let

  background     = "#1d1f21";
  background-wm  = "#444444";
  background-alt = "#2d2d2d";
  foreground     = "#d8dee9";
  foreground-alt = "#555555";
  primary        = "#3c71ea";
  alert          = "#ed0b0b";

  #ac = "#1E88E5";
  #mf = "#383838";

  #bg = "#171717";
  #fg = "#b8b9b4";

  #white = "#c5c8c6";

  ## Colored
  #primary = "#ffb973";

  ## Dark
  #secondary = "#140e0a";

  ## Colored (light)
  #tertiary = "#74c2d4";

  ## white
  #quaternary = "#ecf0f1";

  ## middle gray
  #quinternary = "#384245";

  ## Red
  #urgency = "#e74c3c";

in
{
  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3GapsSupport = true;
    };

    script = "polybar -q -r top & polybar -q -r bottom &";

    config = {

      "settings" = {
        throttle-output = 5;
        throttle-output-for = 10;
        throttle-input-for = 30;

        screenchange-reload = true;

        #format-foreground = "";
        #format-underline = "#268bd2";
        format-background = "";
        format-padding = 1;
        format-margin = 0;

        compositing-background = "source";
        compositing-foreground = "over";
        compositing-overline = "over";
        compositing-underline = "over";
        compositing-border = "over";

        pseudo-transparency = false;

        tray-position = "right";
        tray-padding = 1;
        tray-background = background;
        tray-offset-x = 0;
        tray-offset-y = 0;
        tray-scale = 1;
      };

      "global/wm" = {
        margin-top = 0;
        margin-bottom = 0;
      };

      "bar/top" = {
        bottom = false;
        fixed-center = true;

        width = "100%";
        height = 30;
        offset-x = 8;
        offset-y = 8;
        margin-left = 8;
        margin-right = 8;

        enable-ipc = true;

        background = background;
        foreground = foreground;

        font-0 = "Liberation Mono:size=12;3";
        font-1 = "FuraCode Nerd Font:style=Bold:size=12;3";
        line-size = 1;

        modules-left = "i3";
        modules-center = "title";
        modules-right = "network battery backlight audio date powermenu";
      };

      "bar/bottom" = {
        bottom = true;
        fixed-center = true;

        width = "100%";
        height = 30;
        offset-x = 8;
        offset-y = 8;
        margin-left = 8;
        margin-right = 8;

        background = background;
        foreground = foreground;

        font-0 = "Liberation Mono:size=12;3";
        font-1 = "FuraCode Nerd Font:style=Bold:size=12;3";

        modules-left = "distro-icon";
        modules-right = "cpu memory";
      };

      "module/distro-icon" = {
        type = "custom/script";
        exec = "${pkgs.coreutils}/bin/uname -r | ${pkgs.coreutils}/bin/cut -d- -f1";
        interval = 999999999;

        format = " <label>";
        #format-background = primary;
        #format-foreground = secondary;
        format-padding = 1;
        label = "%output%";
        label-font = 1;
      };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = false;
        strip-wsnumbers = true;
        format = "<label-mode> <label-state>";
        #format-background = tertiary;
        ws-icon-0 = "1;";
        ws-icon-1 = "2;";
        ws-icon-2 = "3;﬏";
        ws-icon-3 = "4;ﭮ";
        ws-icon-4 = "5;";
        ws-icon-5 = "6;";
        ws-icon-6 = "7;";
        ws-icon-7 = "8;";
        ws-icon-8 = "9;";
        ws-icon-9 = "10;";

        label-mode = "%mode%";
        label-mode-padding = 1;

        #label-focused = "%index% %icon%";
        label-focused = "%icon%";
        label-focused-font = 2;
        #label-focused-foreground = secondary;
        label-focused-padding = 1;
        label-focused-background = background-wm;
        label-focused-underline = primary;

        label-unfocused = "%icon%";
        #label-unfocused-foreground = quinternary;
        label-unfocused-padding = 1;

        label-visible = "%icon%";
        label-visible-padding = 1;

        label-urgent = "%index%";
        #label-urgent-foreground = urgency;
        label-urgent-padding = 1;
        label-separator = "|";
      };

      "module/battery" = {
        type = "internal/battery";
        full-at = 101; # to disable it
        battery = "BAT0"; # TODO: Better way to fill this
        adapter = "AC0";

        poll-interval = 2;

        label-full = " 100%";
        format-full-padding = 1;
        #format-full-foreground = secondary;
        #format-full-background = primary;

        format-charging = " <animation-charging> <label-charging>";
        format-charging-padding = 1;
        #format-charging-foreground = secondary;
        #format-charging-background = primary;
        #label-charging = "%percentage%% +%consumption%W";
        label-charging = "%percentage%%";
        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";
        animation-charging-framerate = 500;

        format-discharging = "<ramp-capacity> <label-discharging>";
        format-discharging-padding = 1;
        #format-discharging-foreground = secondary;
        #format-discharging-background = primary;
        #label-discharging = "%percentage%% -%consumption%W";
        label-discharging = "%percentage%%";
        ramp-capacity-0 = "";
        #ramp-capacity-0-foreground = urgency;
        ramp-capacity-1 = "";
        #ramp-capacity-1-foreground = urgency;
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";
      };

      "module/title" = {
        type = "internal/xwindow";
        format = "<label>";
        label = "%title%";
        label-maxlen = 70;
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 3;
        format = " <label>";
        #format-background = tertiary;
        #format-foreground = secondary;
        format-padding = 1;
        label = "RAM %percentage_used%%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = "0.5";
        format = " <label>";
        #format-foreground = quaternary;
        #format-background = secondary;
        format-padding = 1;
        label = "CPU %percentage%%";
      };

      "module/network" = {
        type = "internal/network";
        interface = "wlp0s20f3";

        interval = "1.0";

        accumulate-stats = true;
        unknown-as-up = true;

        format-connected = "<label-connected>";
        #format-connected-background = mf;
        #format-connected-underline = bg;
        #format-connected-overline = bg;
        format-connected-padding = 2;
        format-connected-margin = 0;

        format-disconnected = "<label-disconnected>";
        #format-disconnected-background = mf;
        #format-disconnected-underline = bg;
        #format-disconnected-overline = bg;
        format-disconnected-padding = 2;
        format-disconnected-margin = 0;

        label-connected = "D %downspeed:2% | U %upspeed:2%";
        label-disconnected = "DISCONNECTED";
      };

      "module/date" = {
        type = "internal/date";
        interval = "1.0";
        time = "%H:%M:%S";
        time-alt = "%Y-%m-%d%";
        format = "<label>";
        format-padding = 2;
        #format-foreground = fg;
        label = "%time%";
      };

      "module/temperature" = {
        type = "internal/temperature";

        interval = "0.5";

        thermal-zone = 0; # TODO: Find a better way to fill that
        warn-temperature = 60;
        units = true;

        format = "<label>";
        #format-background = mf;
        #format-underline = bg;
        #format-overline = bg;
        format-padding = 2;
        format-margin = 0;

        format-warn = "<label-warn>";
        #format-warn-background = mf;
        #format-warn-underline = bg;
        #format-warn-overline = bg;
        format-warn-padding = 2;
        format-warn-margin = 0;

        label = "TEMP %temperature-c%";
        label-warn = "TEMP %temperature-c%";
        label-warn-foreground = "#f00";
      };

      "module/powermenu" = {
        type = "custom/menu";
        expand-right = true;

        format = "<label-toggle> <menu>";
        #format-background = secondary;
        format-padding = 1;

        label-open = "";
        label-close = "";
        label-separator = " | ";

        menu-0-0 = " Suspend";
        menu-0-0-exec = "systemctl suspend";
        menu-0-1 = " Reboot";
        menu-0-1-exec = "systemctl reboot";
        menu-0-2 = " Shutdown";
        menu-0-2-exec = "systemctl poweroff";
      };

      "module/backlight" = {
        type = "internal/backlight";
        card = "intel_backlight";

        format = "<label>";
        label = " %percentage%%";
        enable-scroll = false;
      };

      "module/audio" = {
        type = "internal/alsa";

        format-volume = "墳 VOL <label-volume>";
        format-volume-padding = 1;
        #format-volume-foreground = secondary;
        #format-volume-background = tertiary;
        label-volume = "%percentage%%";

        format-muted = "<label-muted>";
        format-muted-padding = 1;
        #format-muted-foreground = secondary;
        #format-muted-background = tertiary;
        format-muted-prefix = "婢 ";
        #format-muted-prefix-foreground = urgency;
        #format-muted-overline = bg;

        label-muted = "VOL Muted";
      };
    };
  };
}
