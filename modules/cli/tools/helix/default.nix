{pkgs, ...}: {
  environment.systemPackages = [pkgs.helix];

  hjem.users.lunarnova.xdg.config.files = {
    "helix/config.toml".source = ./config.toml;
  };
  }
