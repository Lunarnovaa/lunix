{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
  perSystem = {
    config,
    pkgs,
    lib,
    system,
    ...
  }: let
    inherit (lib.filesystem) packagesFromDirectoryRecursive;
  in {
    # My overlay is declared in a separate attrset to allow for
    # 1. People to reference my packages easily as an input
    # 2. My own reference of it within modules as self'.package.<package>
    packages = packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./packages;
    };

    # Here the packages are actually given to the flake-parts module
    # to create the overlay for each system
    overlayAttrs = config.packages;

    # flake-parts does not actually pass the overlay to my flake, so I
    # must do it myself, unfortunately
    legacyPackages = import inputs.nixpkgs {
      inherit system;
      overlays = [inputs.self.overlays.default];
    };

    _module.args.pkgs = config.legacyPackages;
  };
}
