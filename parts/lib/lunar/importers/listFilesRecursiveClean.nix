lib: let
  inherit (lib.trivial) pipe;
  inherit (lib.strings) hasPrefix;
  inherit (lib.lists) flatten;
  inherit (lib.attrsets) mapAttrsToList filterAttrs;
  inherit (lib.lunar.importers) listFilesRecursiveClean;
  inherit (builtins) readDir;
in
  # taken from nixpkgs and modified by me so that any directories
  # with the prefix _ would not have their files imported.
  # yes, i decided to rewrite it as a pipe function.
  # please note you can find the original function under
  # lib.filesystem.listFilesRecursive
  path:
    pipe path [
      readDir
      (filterAttrs (n: _: (!hasPrefix "_" n))) # this is the one part i added to the function
      (mapAttrsToList (
        name: type:
          if type == "directory"
          then listFilesRecursiveClean (path + "/${name}")
          else path + "/${name}"
      ))
      flatten
    ]
