{
  inputs,
  withSystem, # flake-parts option
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

  mkHost = inputs.lunarsLib.builders.mkHost {inherit withSystem inputs moduleDir hostDir;};
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
