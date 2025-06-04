{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.desktops.niri;
in {
  imports = inputs.lunarsLib.importers.listNixRecursive ./.;

  options = {
    lunix.desktops.niri = {
      enable = mkEnableOption "niri: A scrollable-tiling Wayland compositor.";
    };
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;
  };
}
