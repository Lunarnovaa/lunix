{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.profiles.gaming.programs.steam;
in {
  config = mkIf cfg.enable {
    
    programs = {
      steam.enable = true;
      gamescope.enable = true;
    };
    environment = {
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/lunarnova/.steam/root/compatibilitytools.d";
      };
      systemPackages = [pkgs.protonup];
    };
  };
}
