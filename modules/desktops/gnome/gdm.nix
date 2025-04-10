{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.gnome;
in {
  config = mkIf cfg.enable {
    services.xserver.displayManager.gdm = {
      enable = true;
      settings = {
        daemon = {
          User = "lunarnova";
        };
      };
    };
  };
}
