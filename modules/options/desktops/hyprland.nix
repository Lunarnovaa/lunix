{lib, ...}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) listOf str attrs;
in {
  options.desktops.hyprland = {
    enable = mkEnableOption ''
      the Hyprland Wayland Compositor.
    '';
    settings = mkOption {
      type = attrs;
      example = {
        "$mod" = "$super";
        decoration = {
          rounding = "3";
        };
      };
      description = ''
        Settings for Hyprland Wayland Compositor to be
        written to the config file.
      '';
    };
    monitors = {
      configuration = mkOption {
        type = listOf str;
        default = [
          ", preferred, auto, 1"
        ];
        example = [
          "HDMI-A-1, 1920x1080@60, auto, 1"
          "DP-4, 1920x1080@60, auto-left, 1"
        ];
        description = "Monitor configurations for Hyprland";
      };
      bind = mkOption {
        type = listOf str;
        default = [];
        description = "Sets special 'bind' binds for monitor configuration";
      };
      rules = mkOption {
        type = listOf str;
        default = [];
        example = [
          "3, monitor:HDMI-A-1"
          "2, monitor:DP-4, default:true"
        ];
        description = "Sets workspace rules for monitors";
      };
    };
    smartgaps = mkEnableOption ''
      smartgaps for Hyprland.
    '';
  };
}
