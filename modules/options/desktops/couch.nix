{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.desktops.couch = {
    enable = mkEnableOption "couch desktop mode";
  };
}
