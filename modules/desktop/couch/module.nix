{lib, ...}: let
  inherit (lib.lunar.importers) listNixRecursive;
in {
  imports = listNixRecursive ./.;
}
