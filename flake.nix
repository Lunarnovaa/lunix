{
  # https://github.com/Lunarnovaa/lunix
  description = "Lunix: Lunarnova's Nix Flake.";

  outputs = {
    nixpkgs,
    self,
    ...
  }: let
    inherit (builtins) filter;
    inherit (nixpkgs) lib;
    inherit (lib.lists) flatten;
    inherit (lib.filesystem) listFilesRecursive;
    inherit (lib.modules) mkDefault;
    inherit (lib.strings) hasSuffix;
    inherit (lib.trivial) pipe;

    listNixRecursive = dir: pipe dir [
      listFilesRecursive
      (filter (n: hasSuffix ".nix" n))
    ];

    nixos-hardware = fetchGit {
      url = "https://github.com/NixOS/nixos-hardware.git";
      rev = "f8e82243fd601afb9f59ad230958bd073795cbfe";
    };

    mkHost = {
      hostName,
      extraImports ? [],
    }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit lib self;
          inputs = {inherit nixpkgs self;};
          pins = import ./npins;
        };
        modules = flatten [
          {
            networking.hostName = hostName;
          }

          (listNixRecursive ./modules)
          (listNixRecursive (./hosts + /${hostName}))

          extraImports
        ];
      };

    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.callPackage (import ./shell.nix) {};

    nixosConfigurations = {
      polaris = mkHost {
        hostName = "polaris";
      };
      procyon = mkHost {
        hostName = "procyon";

        extraImports = ["${nixos-hardware}/framework/13-inch/7040-amd"];
      };
    };
  };
  # use the unstable branch
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
}
