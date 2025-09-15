{
  programs.nh = {
    enable = true;
    flake = "/home/lunarnova/lunix";
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 3d";
    };
  };
}
