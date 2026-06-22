{
  # https://github.com/Lunarnovaa/lunix
  description = "Lunix: Lunarnova's Nix Flake.";

  outputs = {self, ...}@args: let
    inherit (builtins) filter;
    inherit (inputs.nixpkgs) lib;
    inherit (lib.lists) flatten;
    inherit (lib.filesystem) listFilesRecursive;
    inherit (lib.modules) mkDefault;
    inherit (lib.strings) hasSuffix;
    inherit (lib.trivial) pipe;

    listNixRecursive = dir: pipe dir [
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

          (listNixRecursive ./modules)
          (listNixRecursive (./hosts + /${hostName}))

          extraImports
        ];
      };

    inputs = (import ./.tack) {
      overrides = args.tackOverrides or {};
    };

    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.callPackage (import ./shell.nix) {inherit pkgs;};

    nixosConfigurations = {
      polaris = mkHost {
        hostName = "polaris";
      };
      procyon = mkHost {
        hostName = "procyon";

        extraImports = [inputs.nixos-hardware.nixosModules.framework-13-7040-amd];
      };
    };
  };
}
