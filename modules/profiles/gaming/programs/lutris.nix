{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.programs.lutris;
in {
  options = {
    lunix.programs.lutris = {
      enable = mkEnableOption "Lutris";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.lutris];
  };
}
