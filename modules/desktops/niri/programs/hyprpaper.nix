{
  config,
  pkgs,
  lib,
  inputs,
  theme,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (theme) wallpapers;
  inherit (inputs.lunarsLib.generators) toHyprconf;

  hyprpaper-config = pkgs.writeText "hyprpaper-config" (
    toHyprconf {
      attrs = {
        ipc = false; # no use for ipc on niri
        preload = ["${wallpapers.primary}"];
        wallpaper = [", ${wallpapers.primary}"];
      };
    }
  );

  cfgNiri = config.lunix.desktops.niri;
  cfg = config.lunix.services.hyprpaper;
in {
  options = {
    lunix.services.hyprpaper = {
      enable =
        mkEnableOption "hyprpaper"
        // {
          default = cfgNiri.enable;
          defaultText = "config.lunix.desktops.niri.enable";
        };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.hyprpaper = let
      target = ["graphical-session.target"];
    in {
      description = "Wallpaper utility for Hyprland";
      wantedBy = ["niri.service"];
      partOf = target;
      after = target;
      requisite = target;
      serviceConfig = {
        ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper -c ${hyprpaper-config}";
        Restart = "always";
      };
      restartTriggers = [wallpapers.primary];
    };
  };
}
