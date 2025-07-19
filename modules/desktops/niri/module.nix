{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.modules) mkIf mkDefault;
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
    lunix = {
      displayManagers.sddm.enable = mkDefault true;
      programs.terminal.aliases = {
        iwmenu = "${pkgs.iwmenu}/bin/iwmenu -l walker";
        bzmenu = "${pkgs.bzmenu}/bin/bzmenu -l walker";
      };
    };
    hjem.users.lunarnova = {
      packages = [
        pkgs.xwayland-satellite
        pkgs.brightnessctl
      ];
      files.".config/niri/config.kdl".source = pkgs.concatText "niri-config" (listFilesRecursive ./config);
    };
  };
}
