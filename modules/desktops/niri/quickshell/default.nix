{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfgNiri = config.lunix.desktops.niri;
  cfg = config.lunix.desktops.quickshell;
in {
  options = {
    lunix.desktops.quickshell = {
      enable =
        mkEnableOption "Quickshell"
        // {
          default = cfgNiri.enable;
          defaultText = "config.lunix.desktops.niri";
        };
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.quickshell];
  };
}
