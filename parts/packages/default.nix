{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
  perSystem = {
    config,
    pkgs,
    lib,
    system,
    inputs',
    self',
    ...
  }: let
    #inherit (lib.filesystem) packagesFromDirectoryRecursive;
    inherit (inputs.lunarsLib.importers) packagesFromDirectoryRecursive;
  in {
    # My overlay is declared in a separate attrset to allow for
    # 1. People to reference my packages easily as an input
    # 2. My own reference of it within modules as self'.package.<package>
    packages = packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      specialArgs = {
        inherit inputs inputs' lib pkgs self';
        inherit (config._module.args) theme lunixpkgs pins;
      };
      directory = ./pkgs;
    };

    # Here the packages are actually given to the flake-parts module
    # to create the overlay for each system
    overlayAttrs = config.packages;

    # flake-parts does not actually pass the overlay to my flake, so I
    # must do it myself, unfortunately
    legacyPackages = import inputs.nixpkgs {
      inherit system;

      # This configures my pkgs version as needed within the flake
      # as opposed to at the nixosModules level. This allows me to
      # pass my overlayed 'pkgs' as the pkgs used in my nixosModules,
      # meaning I do not need to use something confusing like "self'.packages.ioshelfka"
      config = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };
      overlays = [inputs.self.overlays.default];
    };

    _module.args.lunixpkgs = config.legacyPackages;
  };
}
