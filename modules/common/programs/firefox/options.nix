{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) enum;
in {
  options = {
    lunix.programs.firefox = {
      enable = mkEnableOption "Firefox Browser";
      app = mkOption {
        type = enum ["mozilla" "schizofox"];
        default = "mozilla";
        example = "schizofox";
        description = ''
          The app to install and configure Firefox with.
        '';
      };
      verticalTabs = mkEnableOption "vertical tabs in Firefox";
    };
  };
}
