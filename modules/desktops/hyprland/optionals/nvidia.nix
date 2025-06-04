{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfgNvidia = config.lunix.hardware.nvidia;
  cfg = config.lunix.desktops.hyprland;
in {
  config = mkIf (cfg.enable && cfgNvidia.enable) {
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
