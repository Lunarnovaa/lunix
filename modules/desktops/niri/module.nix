{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (builtins) concatStringsSep;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.lists) singleton;
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkEnableOption;
  inherit (lib.trivial) pipe;

  niriEnvironment = pipe config.hjem.users.lunarnova.environment.sessionVariables [
    (mapAttrsToList (n: v: n + " \"${v}\""))
    (concatStringsSep "\n")
  ];

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
      xdg.config.files."niri/config.kdl".source = pkgs.concatText "niri-config" (
        listFilesRecursive ./config
        ++ singleton (pkgs.writeText "niri-env-vars" ''
          environment {
            ${niriEnvironment}
            DISPLAY ":0"
          }
        '')
      );
    };
  };
}
