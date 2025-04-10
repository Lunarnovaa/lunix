{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.desktop.couch = {
    enable = mkEnableOption "couch desktop mode";
  };
}
