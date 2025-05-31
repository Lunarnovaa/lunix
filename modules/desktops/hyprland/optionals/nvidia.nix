{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  nvidiaCfg = config.sysconf.nvidia;
  cfg = config.desktops.hyprland;
in {
  config = mkIf (cfg.enable && nvidiaCfg.enable) {
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
