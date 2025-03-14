{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.gnome;
in {
  config = mkIf (cfg.enable && cfg.extensions.enable) {
    desktops.gnome.extensions.packages = with pkgs.gnomeExtensions; [appindicator];
    services.udev.packages = [pkgs.gnome-settings-daemon];
  };
}
