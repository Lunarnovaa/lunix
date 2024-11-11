{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkIf
    mkForce
    ;
in {
  config = mkIf (config.hyprland.enable && config.performance.enable) {
    wayland.windowManager.hyprland.settings = {
      decoration = {
        blur.enabled = false;
        shadow.enabled = false;
      };
      misc.vfr = true;
    };
    services.hyprpaper.settings = {
      ipc = mkForce false;
    };
  };
}
