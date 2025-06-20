{
  lunarsLib,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
in {
  imports = lunarsLib.importers.listNixRecursive ./.;

  options = {
    lunix.profiles.server = {
      enable = mkEnableOption "server profile modules";
    };
  };
}
