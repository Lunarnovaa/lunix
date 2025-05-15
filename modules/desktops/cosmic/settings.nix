{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (inputs.lunarsLib.generators.ron) toRON;
  inherit (lib.attrsets) mergeAttrsList mapAttrsToList mapAttrs' nameValuePair;

  /*
  Credit to dindresto for assistance with the function 'mkSettings'

  # In essence, it takes an attrset like:

   settings = {
     foo = {
       x = 1;
       y = 2;
     };
     bar = {
       z = {
         n = 1;
         m = 2;
       };
     };
   };

  # and turns it into a set of files managed by hjem like:

   ".config/cosmic/com.system76.foo/v1/x".text = ''1'';
   ".config/cosmic/com.system76.foo/v1/y".text = ''2'';
   ".config/cosmic/com.system76.bar/v1/z".text = ''
     (
       n: 1,
       m: 2,
     )
   '';

  # the attrset is of course converted with the toRON generator
  # seen in parts/lib/lunar/generators/ron.nix

  # in the future, the version ("v1") may become configurable,
  # but for now, i could not see why that would be useful.
  */
  mkSettings = settings:
    mergeAttrsList (
      mapAttrsToList (
        n:
          mapAttrs' (
            n': v':
              nameValuePair ".config/cosmic/com.system76.${n}/v1/${n'}" {
                text = toRON 0 v';
              }
          )
      )
      settings
    );

  cfg = config.desktops.cosmic;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova.files = mkSettings cfg.settings;
  };
}
