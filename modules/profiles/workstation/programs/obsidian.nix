{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.profiles.workstation.programs.obsidian;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = [pkgs.obsidian];
    };
  };
}
