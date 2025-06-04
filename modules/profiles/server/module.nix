{
  inputs,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
in {
  imports = inputs.lunarsLib.importers.listNixRecursive ./.;

  options = {
    lunix.profiles.server = {
      enable = mkEnableOption "server profile modules";
    };
  };
}
