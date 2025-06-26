{
  config,
  lib,
  theme,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (theme) fonts;
  inherit (builtins) toString;

  colors = theme.colorsNoHash;

  cfg = config.lunix.programs.foot;
in {
  options = {
    lunix.programs.foot = {
      enable = mkEnableOption "foot";
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova.rum.programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "${fonts.monospace.name}:size=${toString fonts.size}";
          pad = "6x3";
        };
        mouse.hide-when-typing = "yes";

        cursor = {
          blink = "yes";
          color = "${colors.base11} ${colors.base06}";
        };
        colors = {
          foreground = colors.base05;
          background = colors.base01;

          regular0 = colors.base03;
          regular1 = colors.base08;
          regular2 = colors.base0B;
          regular3 = colors.base0A;
          regular4 = colors.base0D;
          regular5 = colors.base17;
          regular6 = colors.base0C;
          regular7 = "bac2de"; # subtext 1, not in basix

          bright0 = colors.base04;
          bright1 = colors.base08;
          bright2 = colors.base0B;
          bright3 = colors.base0A;
          bright4 = colors.base0D;
          bright5 = colors.base17;
          bright6 = colors.base0C;
          bright7 = "a6adc8"; # subtext 0, not in basix

          "16" = colors.base09;
          "17" = colors.base06;

          selection-foreground = colors.base05;
          selection-background = colors.base03;

          search-box-no-match = "${colors.base11} ${colors.base08}";
          search-box-match = "${colors.base05} ${colors.base02}";

          jump-labels = "${colors.base11} ${colors.base09}";
          urls = colors.base0D;
        };
      };
    };
  };
}
