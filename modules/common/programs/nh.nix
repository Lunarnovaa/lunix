{
  programs.nh = {
    enable = true;
    flake = "/home/lunarnova/lunix";
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };
}
