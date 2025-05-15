{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.profiles.workstation.programs.libreoffice;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = [pkgs.libreoffice];
    };
  };
}
