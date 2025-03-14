{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.hyprland;
  syscfg = config.sysconf;
in {
  config = mkIf (cfg.enable && syscfg.powersave) {
    programs.hyprland.settings = {
      decoration = {
        blur.enabled = false;
        shadow.enabled = false;
      };
      misc.vfr = true;
    };
  };
}
