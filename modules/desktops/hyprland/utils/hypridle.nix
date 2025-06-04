{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (inputs.lunarsLib.generators) toHyprconf;

  swaylock = "${pkgs.swaylock-effects}/bin/swaylock -C /home/lunarnova/.config/swaylock/config";

  cfg = config.lunix.desktops.hyprland;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova.files.".config/hypr/hypridle.conf".text = toHyprconf {
      attrs = {
        general = {
          lock_cmd = "pidof ${swaylock} || ${swaylock}";
          before_sleep_cmd = "${swaylock}";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 300; # 5 minute idle = screenlock
            on-timeout = "${swaylock}";
          }
          {
            timeout = 900; # 15 minute idle = monitor off
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };

    systemd.user.services.hypridle = {
      description = "an idle daemon for hyprland";
      after = ["graphical-session.target"];
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      reloadTriggers = ["${config.hjem.users.lunarnova.files.".config/hypr/hypridle.conf".text}"];

      unitConfig.ConditionEnvironment = "WAYLAND_DISPLAY";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.hypridle}/bin/hypridle";
        Restart = "always";
        RestartSec = "10";
      };
    };
  };
}
