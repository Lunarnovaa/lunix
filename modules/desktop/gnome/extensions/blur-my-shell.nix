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
    desktops.gnome.extensions.packages = [pkgs.gnomeExtensions.blur-my-shell];
    /*
      programs.dconf.profiles.lunarnova.databases = [
      {
        settings."org/gnome/shell/extensions/blur-my-shell" = {
          brightness = 0.75;
          noise-amount = 0;
        };
      }
    ];
    */
  };
}
