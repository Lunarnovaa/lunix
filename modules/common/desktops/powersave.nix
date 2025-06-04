{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options = {
    lunix.hardware.powersave = {
      enable = mkEnableOption "power saving settings";
    };
  };
}
