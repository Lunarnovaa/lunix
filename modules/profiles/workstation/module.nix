{
  lunarsLib,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
in {
  imports = lunarsLib.importers.listNixRecursive ./.;

  options = {
    lunix.profiles.workstation = {
      enable = mkEnableOption "workstation profile modules";
    };
  };
}
