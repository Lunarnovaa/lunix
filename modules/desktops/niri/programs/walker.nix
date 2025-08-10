{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  #json = pkgs.formats.json {};

  cfgNiri = config.lunix.desktops.niri;
  cfg = config.lunix.programs.walker;
in {
  options = {
    lunix.programs.walker = {
      enable =
        mkEnableOption "Walker - Application Launcher"
        // {
          default = cfgNiri.enable;
          defaultText = "config.lunix.desktops.niri.enable";
        };
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      rum.desktops.niri.spawn-at-startup = [["walker" "--gapplication-service"]];
      packages = [pkgs.walker];
      #files.".config/walker".text = json.generate "walker.json" {

      #};
    };
  };
}
