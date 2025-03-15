{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lunar.generators.ron) toRON;
  inherit (lib.attrsets) mergeAttrsList mapAttrsToList mapAttrs' nameValuePair;

  # Credit to dindresto for assistance with the function 'mkSettings'
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
