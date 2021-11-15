{ config, lib, pkgs, ... }:
let

  # nvim-cmp with cmdline support is not yet in release-21.05. Build it
  # outselves for now.
  # TODO: remove after pulling in from release-21.05.
  nvim-cmp-latest = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-cmp";
    version = "2021-11-13";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "753f5b7c92da0302efffc5ce6780dffe0602bdf3";
      sha256 = "0b9il665jjc94bp8gdvj4ra5qsbpcfjkvlsvi8miylanfycfmqy5";
    };
    meta.homepage = "https://github.com/hrsh7th/nvim-cmp/";
  };

  # cmp-cmdline is not yet in release-21.05. Build it ourselves for now.
  # TODO: remove after pulling in from release-21.05.
  cmp-cmdline = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "cmp-cmdline";
    version = "2021-11-08";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-cmdline";
      rev = "0ca73c3a50b72c2ca168d8904b39aba34d0c4227";
      sha256 = "1777rv9mh3bar8lp5i4af7kip5j3s4ib8a83b67clga8pcdjla4d";
    };
    meta.homepage = "https://github.com/hrsh7th/cmp-cmdline/";
  };

  vim-godebug = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-godebug";
    version = "2021-11-14";
    src = pkgs.fetchFromGitHub {
      owner = "jodosha";
      repo = "vim-godebug";
      rev = "4ad62ca7612666890b08b7906e16b8c3c5c582f4";
      sha256 = "1gm3xci1wf2fyfp68y7ig3qdn675sclrir64vvqbikk4bclb150f";
    };
    meta.homepage = "https://github.com/jodosha/vim-godebug";
  };

in {
  programs.neovim = {
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
      nvim-cmp-latest
      nvim-lspconfig
      nvim-lsputils
      nvim-treesitter
      popfix
      rust-vim
      syntastic
      tagbar
      unite
      vim-airline
      vim-airline-themes
      vim-fugitive
      vim-go
      vim-hcl
      vim-multiple-cursors
      vim-nix
      vim-surround
      vim-tmux
      vim-tmux-focus-events
      vim-tmux-navigator
      vim-unimpaired
      vimproc
      vimspector
      vimwiki
    ]) ++ [
      vim-godebug
    ];
    extraConfig = builtins.readFile ./vimrc;
  };

  xdg.configFile."vim/Tomorrow-Night.vim".text =
    builtins.readFile ./Tomorrow-Night.vim;

  xdg.configFile."vim/vimspector/configurations/linux/go/config.json".text =
    builtins.readFile ./vimspector-go.json;
}
