{
  lib,
  ...
}: {
  perSystem = let
    lunarsLib = {
      importers = {
        listFilesRecursiveClean = import ./importers/listFilesRecursiveClean.nix {inherit lib;};
        listNixRecursive = import ./importers/listNixRecursive.nix {inherit lib lunarsLib;};
      };
      builders.mkHost = import ./builders/mkHost.nix {inherit lib lunarsLib;};
    };
  in {
    _module.args = {inherit lunarsLib;};
  };
}
