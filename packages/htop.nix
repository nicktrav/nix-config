{ ... }: {
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_treads = true;
      hide_treads = true;
      hide_userland_threads = true;
      highlight_base_name = true;
      show_program_paths = false;
      tree_view = true;
    };
  };
}
