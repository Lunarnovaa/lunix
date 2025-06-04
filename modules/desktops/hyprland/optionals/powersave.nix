{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfgPowersave = config.lunix.hardware.powersave;
  cfg = config.lunix.desktops.hyprland;
in {
  config = mkIf (cfg.enable && cfgPowersave.enable) {
    programs.hyprland.settings = {
      decoration = {
        blur.enabled = false;
        shadow.enabled = false;
      };
      misc.vfr = true;
    };
  };
}
