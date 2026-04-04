{
  inputs,
  withSystem, # flake-parts option
  ...
}: let
  inherit (builtins) fetchGit;

  top = ../.;
  moduleDir = top + /modules;
  hostDir = top + /hosts;

  nixos-hardware = fetchGit {
    url = "https://github.com/NixOS/nixos-hardware.git";
    rev = "f8e82243fd601afb9f59ad230958bd073795cbfe";
  };

  mkHost = inputs.lunarsLib.builders.mkHost {inherit withSystem inputs moduleDir hostDir;};
in {
  flake.nixosConfigurations = {
    # If you're wondering what "mkHost" is, check lib/lunar/builders/mkHost.nix
    polaris = mkHost {
      system = "x86_64-linux";
      hostName = "polaris";
    };
    procyon = mkHost {
      system = "x86_64-linux";
      hostName = "procyon";

      extraImports = ["${nixos-hardware}/framework/13-inch/7040-amd"];
    };
  };
}
