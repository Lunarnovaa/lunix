{
  inputs,
  withSystem, # flake-parts option
  self,
  lib,
  ...
}: let
  top = ../.;
  moduleDir = top + /modules;
  hostDir = top + /hosts;

  default = {
    profiles = [
      "gaming"
      "workstation"
      #"server"
    ];
    desktops = [
      "cosmic"
      "niri"
    ];
  };

  lunarsLib = import self.pins.lunarsLib lib;

  mkHost = lunarsLib.builders.mkHost {
    inherit withSystem inputs moduleDir hostDir;
    inherit (inputs.nixpkgs.lib) nixosSystem;
  };
in {
  flake.nixosConfigurations = {
    # If you're wondering what "mkHost" is, check lib/lunar/builders/mkHost.nix
    polaris = mkHost {
      system = "x86_64-linux";
      hostName = "polaris";

      inherit (default) profiles desktops;
    };
    procyon = mkHost {
      system = "x86_64-linux";
      hostName = "procyon";

      inherit (default) profiles desktops;

      extraImports = [inputs.nixos-hardware.nixosModules.framework-13-7040-amd];
    };
  };
}
