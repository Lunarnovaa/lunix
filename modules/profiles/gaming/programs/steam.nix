{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfgGaming = config.lunix.profiles.gaming;
  cfg = config.lunix.programs.steam;
in {
  options = {
    lunix.programs.steam = {
      enable =
        mkEnableOption "Steam"
        // {
          default = cfgGaming.enable;
          defaultText = "config.lunix.profiles.gaming.enable";
        };
      steam-hardware.enable =
        mkEnableOption "Steam hardware support"
        // {
          default = cfgGaming.enable;
          defaultText = "config.lunix.profiles.gaming.enable";
        };
    };
  };

  config = mkIf cfg.enable {
    lunix.environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/lunarnova/.steam/root/compatibilitytools.d";
    programs = {
      steam = {
        enable = true;
        extest.enable = true;
      };
      gamescope.enable = true;
    };
    hardware.steam-hardware.enable = cfg.steam-hardware.enable;
    environment = {
      systemPackages = [pkgs.protonup];
    };
  };
}
