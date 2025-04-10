lib: let
  inherit (lib) nixosSystem;
  inherit (lib.lunar.builders) mkModules;
in
  # Please note, this fucked up function was inspired by notashelf/nyx,
  # especially the module importing function.
  # Basically, to minimize the re-use of code, I created a custom function
  # calling for all the special details I would need per host.
  # Mainly, it's useful with my flake-parts system to reduce the clutter
  # induced by "withSystem," but the module importing function especially
  # is unique, which imports only the modules needed for the profiles and desktops declared
  {
    inputs,
    withSystem,
    system,
    hostName,
    desktops ? [],
    profiles ? [],
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
          inherit (config._module.args) theme lunixpkgs;
        };
        modules = mkModules {
          inherit
            hostName
            system
            desktops
            profiles
            extraImports
            ;
        };
      })
