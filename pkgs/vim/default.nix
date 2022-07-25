{ config, lib, pkgs, ... }:

let

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

in
{
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
      nvim-cmp
      nvim-lspconfig
      nvim-lsputils
      nvim-treesitter
      plenary-nvim
      popfix
      rust-vim
      syntastic
      telescope-nvim
      vim-airline
      vim-airline-themes
      vim-fugitive
      # TODO: this package is broken - fix.
      #vim-go
      vim-hcl
      vim-nix
      vim-tmux
      vim-tmux-focus-events
      vim-tmux-navigator
      vimspector
    ]) ++ [
      vim-godebug
    ];
    extraConfig = builtins.readFile ./vimrc;
  };

  home.packages = with pkgs; [
    rnix-lsp
    tree-sitter
  ];

  xdg.configFile."vim/Tomorrow-Night.vim".text =
    builtins.readFile ./Tomorrow-Night.vim;

  xdg.configFile."vim/vimspector/configurations/linux/go/config.json".text =
    builtins.readFile ./vimspector-go.json;
}
