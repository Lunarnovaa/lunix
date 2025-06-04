{
  config,
  lib,
  pkgs,
  theme,
  inputs,
  ...
}: let
  inherit (lib.attrsets) mergeAttrsList optionalAttrs;
  inherit (lib.modules) mkIf;
  inherit (inputs.lunarsLib.generators) toHyprconf;
  inherit (theme) wallpapers;

  hyprpaper-conf = pkgs.writeTextFile {
    name = "hyprpaper-conf";
    text = toHyprconf {
      attrs = mergeAttrsList [
        {
          preload = [
            "${wallpapers.primary}"
          ];
          wallpaper = [
            ",${wallpapers.primary}"
          ];
        }
        (optionalAttrs cfgPowersave.enable {
          ipc = false;
        })
      ];
    };
  };

  cfgPowersave = config.lunix.hardware.powersave;
  cfg = config.lunix.desktops.hyprland;
in {
  config = mkIf cfg.enable {
    systemd.user.services.hyprpaper = {
      description = "wallpaper service for hyprland";
      partOf = ["graphical-session.target"];
      wantedBy = ["graphical-session.target"];
      after = ["graphical-session.target"];
      reloadTriggers = ["${hyprpaper-conf}"];

      unitConfig.ConditionEnvironment = "WAYLAND_DISPLAY";
      serviceConfig = {
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper -c ${hyprpaper-conf}";
        Restart = "always";
        RestartSec = "10";
      };
    };
  };
}
