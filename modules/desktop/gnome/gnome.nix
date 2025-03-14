{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.gnome;
in {
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
    };
    programs.dconf.enable = true;
  };
}
