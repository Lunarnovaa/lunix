{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.loose = {
    spicetify.enable = mkEnableOption ''
      the official Spotify client with theming from Spicetify.
    '';

    via.enable = mkEnableOption ''
      via, a keyboard configuration tool, and set udev rules
      for functionality.
    '';
  };
}
