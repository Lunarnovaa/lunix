{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.gnome;
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
