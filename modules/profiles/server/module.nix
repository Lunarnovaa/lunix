{
  inputs,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (inputs.lunarsLib.importers) listNixRecursive;
in {
  imports = listNixRecursive ./.;

  options = {
    lunix.profiles.server = {
      enable = mkEnableOption "server profile modules";
    };
  };
}
