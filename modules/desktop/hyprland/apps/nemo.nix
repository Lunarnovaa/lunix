{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.hyprland;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova.packages = [pkgs.nemo];
  };
}
