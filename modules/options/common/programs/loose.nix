{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.loose = {
    bottom = mkEnableOption ''
      bottom, a graphical process/system monitor tool.
    '';

    fastfetch = mkEnableOption ''
      fastfetch, a highly-configurable fetching tool.
    '';

    spicetify = mkEnableOption ''
      the official Spotify client with theming from Spicetify.
    '';

    via = mkEnableOption ''
      via, a keyboard configuration tool, and set udev rules
      for functionality.
    '';
  };
}
