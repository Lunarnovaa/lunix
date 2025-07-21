{
  config,
  pkgs,
  lib,
  theme,
  ...
}: let
  inherit (builtins) toString;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (theme.fonts) monospace size;
  inherit (theme.colors) base06 base05 base00 base08;

  # From Home Manager - MIT License Applies
  toDunstIni = lib.generators.toINI {
    mkKeyValue = key: value: let
      value' =
        if lib.isBool value
        then (lib.hm.booleans.yesNo value)
        else if lib.isString value
        then ''"${value}"''
        else toString value;
    in "${key}=${value'}";
  };
  # End of MIT License - GPLv3 License Applies

  cfgNiri = config.lunix.desktops.niri;
  cfg = config.lunix.services.dunst;
in {
  options = {
    lunix.services.dunst = {
      enable =
        mkEnableOption "Dunst"
        // {
          default = cfgNiri.enable;
          defaultText = "config.lunix.desktops.niri.enable";
        };
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova.packages = [pkgs.dunst];
    hjem.users.lunarnova.xdg.config.files."dunst/dunstrc".text = toDunstIni {
      global = {
        width = 300;
        height = "(0,300)";
        offset = "(20,20)";
        origin = "top-left";
        transparency = 10;
        frame_color = base06; # rosewater
        separator_color = "frame";
        highlight = base06; # rosewater
        font = "${monospace.name} ${toString size}";
        frame_width = 2;
        gap_size = 4;
        vertical_alignment = "top";
        icon_theme = config.hjem.users.lunarnova.rum.misc.gtk.settings.icon-theme-name;
        dmenu = "walker -d -p dunst";
        corner_radius = 0;
      };

      urgency_low = {
        background = base00; # base
        foreground = base05; # text
        timeout = 10;
      };

      urgency_normal = {
        background = base00; # base
        foreground = base05; # text
        timeout = 15;
      };
      urgency_critical = {
        frame_color = base08; # red
        highlight = base08; # red
        background = base00; # base
        foreground = base05; # text
        timeout = 30;
      };
    };
  };
}
