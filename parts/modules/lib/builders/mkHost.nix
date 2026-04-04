{
  lib,
  self,
  ...
}: let
  inherit (lib) nixosSystem;
  inherit (lib.modules) mkDefault;
  inherit (lib.lists) flatten;
  inherit (self.importers) listNixRecursive;
  inherit (builtins) map;
in
  /*
  Please note, this fucked up function was inspired by NotAShelf/nyx,
  especially the module importing function.
  Basically, to minimize the re-use of code, I created a custom function
  calling for all the special details I would need per host.
  Mainly, it's useful with my flake-parts system to reduce the clutter
  induced by "withSystem," but the module importing function especially
  is unique, which imports only the modules needed for the profiles and desktops declared
  */
  {
    inputs,
    withSystem,
    moduleDir,
    hostDir,
  }:
  /*
  I break the attrset of inputs into two in order to allow myself to break up the function
  inputs into lambdas allowing me to reduce the amount of boiler plate in my code. Please
  see Lunarnovaa/Lunix:hosts/default.nix for an example of this.
  */
  {
    system,
    hostName,
    extraImports ? [],
  }:
    withSystem system ({
      self',
      config,
      inputs',
      ...
    }:
      nixosSystem {
        specialArgs = {
          inherit lib inputs;
          inherit self' inputs';
          inherit (config._module.args) theme lunixpkgs pins;
          lunarsLib = self;
        };
        modules = flatten [
          {
            # Declare the hostName c:
            networking.hostName = hostName;

            nixpkgs = {
              hostPlatform = mkDefault system;
            };
          }
          # All hosts import the common modules
          (listNixRecursive (moduleDir + /common))

          # Import host modules
          (listNixRecursive (hostDir + /${hostName}))

          # Additional modules for importation can be declared as well.
          # This is usually system specific stuff.
          extraImports
        ];
      })
