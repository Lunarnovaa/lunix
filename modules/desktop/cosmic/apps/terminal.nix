{
  config,
  lib,
  theme,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (theme.fonts) monospace;

  cfg = config.desktops.cosmic;
in {
  config = mkIf cfg.enable {
    desktops.cosmic.settings.CosmicTerm = {
      font_name = monospace.name;
      font_size = 14;
      opacity = 100;
      show_headerbar = false;
      focus_follows_mouse = true;
    };
  };
}
