{
  config,
  lib,
  theme,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.gnome;
in {
  config = mkIf cfg.enable {
    programs.dconf.profiles.lunarnova.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
          };
          "org/gnome/desktop/background".picture-uri = theme.wallpapers.primary;
        };
      }
    ];
  };
}
