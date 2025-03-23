# Partially taken and modified from https://github.com/nix-community/home-manager
# the function itself is available under the MIT License.
lib: {attrs}: let
  inherit (lib) concatStrings mapAttrsToList;
in
  concatStrings (mapAttrsToList (n: v:
    if v == false
    then ""
    else
      (
        if v == true
        then n
        else n + "=" + builtins.toString v
      )
      + "\n")
  attrs)
