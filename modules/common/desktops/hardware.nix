{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) str;
in {
  options = {
    lunix.hardware = {
      display = {
        width = mkOption {
          type = str;
          default = "1920";
          example = "2560";
          description = "Width of the system's display.";
        };
        height = mkOption {
          type = str;
          default = "1080";
          example = "1440";
          description = "Height of the system's display.";
        };
      };
      powersave = {
        enable = mkEnableOption "power saving settings";
      };
    };
  };
}
