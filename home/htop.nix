{ ... }: {
  programs.htop = {
    enable = true;
    settings = {
      hide_treads = true;
      show_program_paths = false;
      tree_view = true;
    };
  };
}
