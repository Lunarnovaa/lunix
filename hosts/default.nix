{
  inputs,
  self,
}: let
  inherit (builtins) filter;
  inherit (inputs.nixpkgs) lib;
  inherit (lib.lists) flatten;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
  inherit (lib.trivial) pipe;

  listNixRecursive = dir:
    pipe dir [
      listFilesRecursive
      (filter (n: hasSuffix ".nix" n))
    ];

  mkHost = {
    hostName,
    extraImports ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit lib inputs self;};
      modules = flatten [
        {
          networking.hostName = hostName;
        }

        (listNixRecursive ../modules)
        (listNixRecursive ./${hostName})

        extraImports
      ];
    };
in {
  polaris = mkHost {
    hostName = "polaris";
  };
  procyon = mkHost {
    hostName = "procyon";

    extraImports = ["${inputs.nixos-hardware}/framework/13-inch/7040-amd"];
  };
}
