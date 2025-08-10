{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (inputs.lunarsLib.importers) listNixRecursive;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.desktops.niri;
in {
  imports = listNixRecursive ./.;

  options = {
    lunix.desktops.niri = {
      enable = mkEnableOption "niri: A scrollable-tiling Wayland compositor.";
    };
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;
    lunix = {
      displayManagers.sddm.enable = mkDefault true;
      programs.terminal.aliases = {
        iwmenu = "${getExe pkgs.iwmenu} -l walker";
        bzmenu = "${getExe pkgs.bzmenu} -l walker";
      };
    };
    hjem.users.lunarnova = {
      rum.desktops.niri = {
        enable = true;
        spawn-at-startup = [
          ["${pkgs.xwayland-satellite}/bin/xwayland-satellite"]
        ];
        extraVariables.DISPLAY = ":0";
        configFile = pkgs.concatText "config.kdl" (listFilesRecursive ./config);
      };
    };
  };
}
