{
  inputs,
  self,
  withSystem, # flake-parts option
  ...
}: let
  inherit (self) lib;
  inherit (lib.extendedLib.builders) mkHost;

  default = {
    profiles = [
      "gaming"
      "workstation"
    ];
    desktop = ["hyprland"];
  };
in {
  flake.nixosConfigurations = {
    # If you're wondering what "mkHost" is, check lib/builders.nix
    polaris = mkHost {
      inherit withSystem;
      system = "x86_64-linux";
      hostName = "polaris";

      inherit (default) profiles desktop;
    };
    procyon = mkHost {
      inherit withSystem;
      system = "x86_64-linux";
      hostName = "procyon";

      inherit (default) profiles desktop;

      specialImports = [inputs.nixos-hardware.nixosModules.framework-13-7040-amd];
    };
  };
}
