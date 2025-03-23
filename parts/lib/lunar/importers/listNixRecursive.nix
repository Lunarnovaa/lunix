lib: let
  inherit (lib.trivial) pipe;
  inherit (lib.strings) hasSuffix hasPrefix;
  inherit (lib.lists) flatten;
  inherit (lib.attrsets) mapAttrsToList filterAttrs;
  inherit (builtins) filter readDir;

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
  # This simple function just lists any nix files that are not the special
  # 'module.nix' file. Previously this was split into an "importNix" that
  # could also import 'module.nix's and an "importModule" that could not,
  # but that quickly became redundant.
  path:
    pipe path [
      listFilesRecursiveClean
      (filter (n: hasSuffix ".nix" n && !hasSuffix "module.nix" n))
    ]
