{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (inputs.lunarsLib.generators.ron) mkRON;

  cfg = config.desktops.cosmic;
in {
  config = mkIf cfg.enable {
    desktops.cosmic.settings.CosmicFiles = {
      tab = {
        show_hidden = true;
        view = mkRON "enum" "Grid";
      };
    };
  };
}
