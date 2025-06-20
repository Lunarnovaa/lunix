{
  lunarsLib,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
in {
  imports = lunarsLib.importers.listNixRecursive ./.;

  options = {
    lunix.profiles.gaming = {
      enable = mkEnableOption "gaming profile modules";
    };
  };
}
