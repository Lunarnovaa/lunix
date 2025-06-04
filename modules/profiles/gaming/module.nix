{
  inputs,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
in {
  imports = inputs.lunarsLib.importers.listNixRecursive ./.;

  options = {
    lunix.profiles.gaming = {
      enable = mkEnableOption "gaming profile modules";
    };
  };
}
