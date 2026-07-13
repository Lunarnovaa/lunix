{config, ...}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 3d";
    };
  };
  lunix.environment.sessionVariables = {
    NH_FILE = "${config.hjem.users.lunarnova.directory}/Projects/lunix/system.nix";
    NH_ATTRP = config.networking.hostName;
  };
}
