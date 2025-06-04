{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfgGaming = config.lunix.profiles.gaming;
  cfg = config.lunix.programs.gamemode;
in {
  options = {
    lunix.programs.gamemode = {
      enable = mkEnableOption "Feral Gamemode" // {default = cfgGaming.enable;};
    };
  };

  config = mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
    };
  };
}
