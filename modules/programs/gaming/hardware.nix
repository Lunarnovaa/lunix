{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;

  cfgGaming = config.lunix.profiles.gaming;
  cfg = config.lunix.profiles.gaming.hardware.xbox-controller;
in {
  options = {
    lunix.profiles.gaming.hardware.xbox-controller = {
      enable =
        mkEnableOption "support for Xbox Controllers"
        // {
          default = cfgGaming.enable;
          defaultText = "config.lunix.profiles.gaming.enable";
        };
    };
  };
  config = mkIf cfg.enable {
    hardware = {
      xpadneo.enable = true;
      xone.enable = true;
    };
  };
}
