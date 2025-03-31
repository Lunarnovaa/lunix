lib: let
  inherit (lib.trivial) pipe;
  inherit (lib.strings) hasSuffix;
  inherit (lib.lunar.importers) listFilesRecursiveClean;
  inherit (builtins) filter;
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
