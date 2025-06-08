{
  inputs,
  lib,
  config,
  theme,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) str int;
  inherit (theme.colors) base06;

  cfg = config.lunix.desktops.niri;
in {
  imports = inputs.lunarsLib.importers.listNixRecursive ./.;

  options = {
    lunix.desktops.niri = {
      enable = mkEnableOption "niri: A scrollable-tiling Wayland compositor.";
      settings = {
        borders = {
          radius = mkOption {
            type = int;
            default = 0;
            example = 2;
            description = "The radius of borders in Niri and its applications.";
          };
          width = mkOption {
            type = int;
            default = 2;
            example = 2;
            description = "The width of borders in Niri and its applications.";
          };
        };
        gaps = {
          width = mkOption {
            type = int;
            default = 4;
            example = 2;
            description = "The width of gaps in Niri and its applications.";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;
    lunix.displayManagers.sddm.enable = mkDefault true;
    systemd.units.niri = {
    };
  };
}
