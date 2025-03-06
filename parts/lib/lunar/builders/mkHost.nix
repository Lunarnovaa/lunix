libArgs: let
  inherit (libArgs.lib) nixosSystem;
  inherit (libArgs.lib.lunar.builders) mkModules;
in
  # Please note, this fucked up function was inspired by notashelf/nyx,
  # especially the module importing function.
  # Basically, to minimize the re-use of code, I created a custom function
  # calling for all the special details I would need per host.
  # Mainly, it's useful with my flake-parts system to reduce the clutter
  # induced by "withSystem," but the module importing function especially
  # is unique, which imports only the modules needed for the profiles and desktops declared
  {
    withSystem,
    system,
    hostName,
    profiles ? [],
    desktop ? [],
    specialImports ? [],
  }:
    withSystem system ({
      self',
      config,
      ...
    }:
      nixosSystem {
        specialArgs = {
          inherit (libArgs) lib inputs;
          inherit self';
          inherit (config._module.args) theme lunarpkgs;
        };
        modules = mkModules {inherit hostName profiles desktop specialImports;};
      })
