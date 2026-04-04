{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfgGaming = config.lunix.profiles.gaming;
  cfg = config.lunix.programs.lutris;
in {
  options = {
    lunix.programs.lutris = {
      enable =
        mkEnableOption "Lutris"
        // {
          default = cfgGaming.enable;
          defaultText = "config.lunix.profiles.gaming.enable";
        };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.lutris];
  };
}
