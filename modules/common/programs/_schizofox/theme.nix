{
  theme,
  lib,
  config,
  ...
}: let
  inherit (theme.fonts) sans;
  inherit (lib.strings) removePrefix;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.modules) mkIf;
  inherit (schizoCol) base00 base01 base05 base06;

  schizoCol = mapAttrs (n: v: removePrefix "#" v) theme.colors;

  cfg = config.firefox;
in {
  hjem.users.lunarnova.programs.schizofox = mkIf (cfg.enable && (cfg.app == "schizofox")) {
    theme = {
      font = sans.name;
      colors = {
        background-darker = base01;
        background = base00;
        foreground = base05;
        primary = base06;
      };
    };
  };
}
