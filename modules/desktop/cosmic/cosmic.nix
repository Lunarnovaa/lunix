{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.cosmic;
in {
  config = mkIf cfg.enable {
    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true; # By default this is enabled
    };
  };
}
