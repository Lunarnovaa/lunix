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
    lunix.profiles.gaming = {
      enable = mkEnableOption "gaming profile modules";
    };
  };
}
