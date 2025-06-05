{
  lib,
  theme,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (theme.fonts) monospace size;
  inherit (theme.colors) base01 base05 base06 base03 base08 base0B base0A base0D base17 base0C base04;

  cfg = config.lunix.programs.ghostty;
in {
  options.lunix.programs.ghostty = {
    enable = mkEnableOption "ghostty" // {default = true;};
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova.rum.programs.ghostty = {
      enable = true;
      settings = {
        font-family = monospace.name;
        font-size = size;
        theme = "base24";
        window-padding-x = 4;
        window-padding-y = 4;
        window-decoration = "none";
        window-height = 28;
        window-width = 101;
      };
      themes.base24 = {
        background = base01;
        foreground = base05;
        cursor-color = base06;
        cursor-text = base01;
        selection-background = "353749";
        selection-foreground = base05;
        palette = [
          "0=${base03}"
          "1=${base08}"
          "2=${base0B}"
          "3=${base0A}"
          "4=${base0D}"
          "5=${base17}"
          "6=${base0C}"
          "7=#bac2de" # subtext 1
          "8=${base04}"
          "9=${base08}"
          "10=${base0B}"
          "11=${base0A}"
          "12=${base0D}"
          "13=${base17}"
          "14=${base0C}"
          "15=#a6adc8" # subtext 0
        ];
      };
    };
  };
}
