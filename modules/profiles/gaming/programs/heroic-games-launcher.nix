{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfgGaming = config.lunix.profiles.gaming;
  cfg = config.lunix.programs.heroic;
in {
  options = {
    lunix.programs.heroic = {
      enable = mkEnableOption "Heroic Games Launcher" // {default = cfgGaming.enable;};
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.heroic];
  };
}
