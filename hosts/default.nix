{
  inputs,
  self,
  withSystem, # flake-parts option
  ...
}: let
  inherit (self) lib;
  inherit (lib.lunar.builders) mkHost;

  default = {
    profiles = [
      "gaming"
      "workstation"
      #"server"
    ];
    desktops = [
      #"hyprland"
      #"gnome"
      "cosmic"
      #"couch"
    ];
  };
in {
  flake.nixosConfigurations = {
    # If you're wondering what "mkHost" is, check lib/lunar/builders/mkHost.nix
    polaris = mkHost {
      inherit withSystem inputs;
      system = "x86_64-linux";
      hostName = "polaris";

      inherit (default) profiles desktops;
    };
    procyon = mkHost {
      inherit withSystem inputs;
      system = "x86_64-linux";
      hostName = "procyon";

      inherit (default) profiles desktops;

      extraImports = [inputs.nixos-hardware.nixosModules.framework-13-7040-amd];
    };
  };
}
