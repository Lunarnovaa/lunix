{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.hyprland;
  syscfg = config.sysconf;
in {
  config = mkIf (cfg.enable && syscfg.nvidia) {
    programs.hyprland.settings = {
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
    };
  };
}
