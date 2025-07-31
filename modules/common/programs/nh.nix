{inputs', ...}: {
  programs.nh = {
    enable = true;
    package = inputs'.nh.packages.default;
    flake = "/home/lunarnova/lunix";
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 3d";
    };
  };
}
