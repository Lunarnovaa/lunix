{
  inputs,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
in {
  imports = inputs.lunarsLib.importers.listNixRecursive ./.;

  options = {
    lunix.profiles.workstation = {
      enable = mkEnableOption "workstation profile modules";
    };
  };
}
