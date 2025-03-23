{
  inputs,
  lib,
  ...
}: let
  inherit (lib.trivial) pipe;
  inherit (lib.strings) removeSuffix;
  inherit (lib.attrsets) mapAttrs' nameValuePair;
  inherit (builtins) readDir;

  /*
  Reworked version of 'listFilesRecursive', that instead creates a nested attrset defining the location
  of an imported nix file.


  # Inputs

  `path`

  : The path to recursively create an attrset from..

  # Type

  ```
  Path -> AttrSet
  ```
  */
  importFilesRecursive = path: lib:
    pipe path [
      readDir
      /*
      This is where the "recursive" part of the name comes from. Basically, files are modified as attrs so
      that name is the name of the function, and value is their file imported. Directories are instead
      recursed into, with path extended accordingly. Ultimately, the location of each function is charted
      as it recurses.
      */
      (mapAttrs' (
        name: type:
          if type == "directory"
          then nameValuePair name (importFilesRecursive (path + "/${name}") lib)
          else
            nameValuePair (
              removeSuffix ".nix" name
            ) (
              import (path + "/${name}") lib
            )
      ))
    ];

  lunar.lib = inputs.nixpkgs.lib.extend (
    final: prev: {
      lunar = importFilesRecursive ./lunar final; # lib is set to the final function, so that it includes lib.lunar
    }
  );
  /*
  Guide for location of functions:
    lib/lunar/importers/listNixRecursive.nix
  becomes
    lib.lunar.importers.listNixRecursive
  */
in {
  # Credit to @notashelf for nyx which I learned how to extend lib in flake-parts from.
  # My implementation is a little janky, but works great.

  perSystem = {
    # Extend lib for the flake
    _module.args = {inherit (lunar) lib;};
  };
  # And also as an output
  flake = {inherit (lunar) lib;};
}
