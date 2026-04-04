/*
This function has been mostly rewritten, but the understanding
of how it works and much of the code is taken from Nixpkgs.
Therefore, it is available under MIT License. Please see
README.md for more information.
*/
{lib, ...}: let
  inherit (lib.trivial) pipe;
  inherit (lib.strings) hasPrefix;
  inherit (lib.lists) flatten;
  inherit (lib.attrsets) mapAttrsToList filterAttrs;
  inherit (builtins) readDir;

  # taken from nixpkgs and modified by me so that any directories
  # with the prefix _ would not have their files imported.
  # yes, i decided to rewrite it as a pipe function.
  # please note you can find the original function under
  # lib.filesystem.listFilesRecursive
  listFilesRecursiveClean = path:
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
    ];
in
  listFilesRecursiveClean
