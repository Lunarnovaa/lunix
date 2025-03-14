{
  config,
  inputs,
  lib,
  inputs',
  ...
}: let
  inherit (lib.modules) mkIf;

  pkgs-unstable = inputs'.hyprland.packages;

  cfg = config.desktops.hyprland;
in {
  imports = [inputs.hyprland.nixosModules.default];

  config = mkIf cfg.enable {
    # Make Chromium + Electron apps use Wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs.hyprland = {
      enable = true;
      # Set package to version defined in the flake
      package = pkgs-unstable.hyprland;
      # Set portal package as well so that they are in sync
      portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;

      # Install and use UWSM, a wayland compositor wrapper for tighter service integration
      withUWSM = true;
    };
  };
}
