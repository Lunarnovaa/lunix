{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.desktops.niri = {
    enable = mkEnableOption "niri";
  };
}
