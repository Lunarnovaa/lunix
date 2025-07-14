{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  #kdl = pkgs.formats.kdl {};

  cfg = config.lunix.desktops.niri;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = [
        pkgs.bzmenu
        pkgs.iwmenu
        pkgs.xwayland-satellite
        pkgs.brightnessctl
      ];
      files.".config/niri/config.kdl".source = ./config.kdl;
    };
    lunix.terminal.aliases = {
      iwmenu = "iwmenu -l walker";
      bzmenu = "bzmenu -l walker";
    };
    /*
      hjem.users.lunarnova.files.".config/niri/config.kdl".text = kdl.generate "niri/config.kdl" {
      input = {
        keyboard.xkb = {
          layout = "us";
          variant = "colemak";
        };
        mouse = {
          accel-speed = 0.2;
          accel-profile = "flat";
        };
        touchpad = {
          natural-scroll = true;
        };
        mod-key = "Super";
      };
      binds = {
        "Mod+N" = {focus-column-left = true;};
        "Mod+E" = {focus-column-down = true;};
        "Mod+I" = {focus-column-right = true;};
        "Mod+U" = {focus-column-up = true;};
      };
    };
    */
  };
}
