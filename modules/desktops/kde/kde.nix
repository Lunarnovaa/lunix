{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.kde;
in {
  config = mkIf cfg.enable {
    services = {
      desktopManager.plasma6.enable = true;
      xserver.enable = true;
    };
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      kate
    ];
    hjem.users.lunarnova.environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
