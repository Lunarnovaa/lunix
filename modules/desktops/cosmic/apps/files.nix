{
  config,
  lib,
  lunarsLib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lunarsLib.generators.ron) mkRON;

  cfg = config.lunix.desktops.cosmic;
in {
  config = mkIf cfg.enable {
    lunix.desktops.cosmic.settings.CosmicFiles = {
      tab = {
        show_hidden = true;
        view = mkRON "enum" "Grid";
      };
    };
  };
}
