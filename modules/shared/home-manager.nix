{ config, pkgs, lib, ... }:

let 
  name = "Nick Travers";
  user = "nickt";
  email = "n.e.travers@gmail.com";

in {

  # Shared shell configuration.
  bash = {
    enable = true;
    bashrcExtra =
      builtins.readFile ./bash/bashrc
      + builtins.readFile ./bash/aliases
      + builtins.readFile ./bash/prompt
      + ''
        export PKCS11_PATH=${pkgs.opensc}/lib/opensc-pkcs11.so
      ''
      + ''
        if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
          . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
          . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
        fi
      '';
  };

  readline = {
    enable = true;
    extraConfig = builtins.readFile ./bash/inputrc;
  };

  # Git configuration.
  git = {
    enable = true;
    includes = [
      { path = "~/.config/git/.gitconfig"; }
    ];
    ignores = [
      "*.claude"
      ".direnv/"
      ".envrc"
      ".idea/"
      ".ijwb/"
      "*.swn"
      "*.swo"
      "*.swp"
      "shell.nix"
    ];
  };

  # FIXME: Figure out how to add back the godebug line.
  neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    plugins = (with pkgs.vimPlugins; [
      base16-vim
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      fzf-vim
      gitgutter
      lsp-colors-nvim
      lsp_extensions-nvim
      lsp_signature-nvim
      luasnip
      nerdtree
      nvim-cmp
      nvim-lspconfig
      nvim-lsputils
      (nvim-treesitter.withPlugins (p: [
        p.bash
        p.go
        p.json
        p.rust
        p.toml
        p.yaml
      ]))
      plenary-nvim
      popfix
      rust-vim
      syntastic
      telescope-fzf-native-nvim
      telescope-nvim
      vim-airline
      vim-airline-themes
      vim-fugitive
      vim-go
      vim-hcl
      vim-nix
      vim-tmux
      vim-tmux-focus-events
      vim-tmux-navigator
    ]);
    extraConfig = builtins.readFile ./vim/vimrc;
  };

  alacritty = {
    enable = true;
    settings = {
      terminal.shell = lib.mkIf pkgs.stdenv.isDarwin {
        program = "${pkgs.bashInteractive}/bin/bash";
      };
      # On the XPS, the DPI scaling makes fonts larger than they should be.
      # Correct for this by disabling scaling. See the following issue for more
      # context: https://github.com/alacritty/alacritty/issues/1501
      env = lib.mkIf (!pkgs.stdenv.isDarwin) {
        WINIT_X11_SCALE_FACTOR = "1.0";
      };
      colors = {
        primary = {
          foreground = "0xb0bec5";
          background = "0x1b1b1b";
        };
        normal = {
          black = "0x313129";
          red = "0x974040";
          green = "0x7cbf68";
          yellow = "0xdd6060";
          blue = "0xff7272";
          magenta = "0xe7a6a6";
          cyan = "0xc79898";
          white = "0xf7f7f7";
        };
        bright = {
          black = "0x708284";
          red = "0x974040";
          green = "0x7cbf68";
          yellow = "0xdd6060";
          blue = "0xff7272";
          magenta = "0xe7a6a6";
          cyan = "0xc79898";
          white = "0xf7f7f7";
        };
      };
      font = {
        # FIXME: Was this removed?
        #antialias = true;
        normal = {
          family = "Inconsolata-dz for Powerline";
        };
        size = 12.0;
      };
      general = {
        live_config_reload = true;
      };
      window = {
        decorations = "none";
        padding = {
          x = 2;
          y = 2;
        };
        startup_mode = "Maximized";
      };
      keyboard.bindings = [
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

  tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];
    # Use the Nix-provided bash instead of macOS's ancient /bin/bash.
    shell = "${pkgs.bashInteractive}/bin/bash";
    extraConfig = ''
      # Change prefix key to `
      set -g prefix C-z
      bind C-z send-prefix
      
      # Default key repeat is 500ms, lower to 125ms
      # otherwise hitting up arrow right after moving to new window counts
      # as moving back to window above
      set -g repeat-time 125
      
      # This works around an issue when using nvim and tmux. When hitting the escape
      # key followed by a second key, the latter is ignored if it quickly follows the
      # former. The following ensures that escape sequences are sent immediately.
      # See: https://github.com/neovim/neovim/issues/2454#issuecomment-164208887
      set -sg escape-time 0
      
      # reload ~/.tmux.conf using PREFIX r
      bind r source-file ~/.config/tmux/tmux.conf
      
      # count from 1
      set -g base-index 1
      
      # More straight forward key bindings for splitting
      unbind %
      bind | split-window -h
      bind - split-window -v
      
      # History
      set -g history-limit 5000
      
      # enable truecolor support
      set -g default-terminal "xterm-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      
      # quick pane cycling
      unbind C-q
      bind ^q select-pane -t :.+
      
      set-option -g history-limit 3000
      
      # vi mode
      setw -g mode-keys vi
      set -g status-keys vi
      bind-key -T edit-mode-vi Up send-keys -X history-up
      bind-key -T edit-mode-vi Down send-keys -X history-down
      
      # scroll mode with escape and use vim-like keys
      unbind [
      bind Escape copy-mode
      unbind p
      bind p paste-buffer
      
      unbind-key -T copy-mode-vi Space
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      
      unbind-key -T copy-mode-vi Enter
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
      
      # Disable login shell. This is problematic on macOS.
      #set -g default-command "$${SHELL}"
      
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r H resize-pane -L 5
      bind -r L resize-pane -R 5
      
      # Smart pane switching with awareness of vim splits
      bind -n C-k run-shell '~/.config/tmux/tmux-vim-select-pane -U'
      bind -n C-j run-shell '~/.config/tmux/tmux-vim-select-pane -D'
      bind -n C-h run-shell '~/.config/tmux/tmux-vim-select-pane -L'
      bind -n C-l run-shell '~/.config/tmux/tmux-vim-select-pane -R'
      bind -n "C-\\" run-shell '~/.config/tmux/tmux-vim-select-pane -l'
      
      # Bring back clear screen under tmux prefix
      bind C-l send-keys 'C-l'
      
      # Install tmux plugins
      #set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins/"
      #set -g @plugin 'tmux-plugins/tpm'
      #set -g @plugin 'christoomey/vim-tmux-navigator'
      #set -g @plugin 'tmux-plugins/vim-tmux'
      #set -g @plugin 'tmux-plugins/vim-cpu'
      #set -g @plugin 'tmux-plugins/vim-battery'
      #set -g @plugin 'thewtex/tmux-mem-cpu-load'
      #set -g @plugin 'tmux-plugins/tmux-yank'
      
      # -----------------------------------------------------------------------------
      # Status bar.
      #
      # Generated via Vim's tmuxline plugin, exported with :TmuxlineSnapshot, and
      # then re-imported here.
      # -----------------------------------------------------------------------------
      
      set -g status-justify "left"
      set -g status "on"
      set -g status-left-style "none"
      set -g message-command-style "fg=#E4E4E4,bg=#4E4E4E"
      set -g status-right-style "none"
      set -g pane-active-border-style "fg=#5FFF87"
      set -g status-style "none,bg=#262626"
      set -g message-style "fg=#E4E4E4,bg=#4E4E4E"
      set -g pane-border-style "fg=#4E4E4E"
      set -g status-right-length "100"
      set -g status-left-length "100"
      setw -g window-status-activity-style "none"
      setw -g window-status-separator ""
      setw -g window-status-style "none,fg=#EEEEEE,bg=#262626"
      set -g status-left "#[fg=#E4E4E4,bg=#3A3A3A] #S #[fg=#3A3A3A,bg=#262626,nobold,nounderscore,noitalics]"
      setw -g window-status-format "#[fg=#EEEEEE,bg=#262626] #I #[fg=#EEEEEE,bg=#262626] #W "
      setw -g window-status-current-format "#[fg=#262626,bg=#4E4E4E,nobold,nounderscore,noitalics]#[fg=#E4E4E4,bg=#4E4E4E] #I #[fg=#E4E4E4,bg=#4E4E4E] #W #[fg=#4E4E4E,bg=#262626,nobold,nounderscore,noitalics]"
      
      # Disable the status line segment that tmuxline generates, as we already have
      # the hostname and date in our polybar config.
      set -g status-right ""
      
      # Set window notifications
      set -g monitor-activity on
      set -g visual-activity off
      
      # -----------------------------------------------------------------------------
      # Epilogue
      # -----------------------------------------------------------------------------
      
      # Keep this line at the very bottom of tmux.conf.
      #run-shell ~/.config/tmux/plugins/tpm/tpm
      #run-shell /nix/store/s24jxd6v3fywf1dylpwim6z68jdmp7nm-vimplugin-vim-tmux-navigator-2020-11-12/share/vim-plugins/vim-tmux-navigator/vim-tmux-navigator.tmux
    '';
    };

  # Go.
  go = {
    enable = true;
    env = {
      GOPATH = "${config.home.homeDirectory}/go";
      GOBIN  = "${config.home.homeDirectory}/go/bin";
    };
  };

  # Fzf.
  fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  # Htop.
  htop = {
    enable = true;
    settings = {
      hide_kernel_treads = true; hide_treads = true; hide_userland_threads = true;
      highlight_base_name = true;
      show_program_paths = false;
      tree_view = true;
    };
  };

  # GPG.
  gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
      pcsc-shared = true;
    };
  };
}
