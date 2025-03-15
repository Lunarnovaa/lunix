{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.cosmic;
in {
  config = mkIf cfg.enable {
    desktops.cosmic.settings.CosmicFiles = {
      tab.show_hidden = true;
    };
  };
}
