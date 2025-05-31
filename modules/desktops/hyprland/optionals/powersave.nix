{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  powersaveCfg = config.sysconf.powersave;
  cfg = config.desktops.hyprland;
in {
  config = mkIf (cfg.enable && powersaveCfg.enable) {
    programs.hyprland.settings = {
      decoration = {
        blur.enabled = false;
        shadow.enabled = false;
      };
      misc.vfr = true;
    };
  };
}
