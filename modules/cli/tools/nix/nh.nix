{
  programs.nh = {
    enable = true;
    flake = "/home/lunarnova/Projects/lunix";
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 3d";
    };
  };
}
