{
  lib,
  config,
  theme,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (theme) colors fonts;

  cfg = config.lunix.programs.alacritty;
in {
  options = {
    lunix.programs.alacritty = {
      enable = mkEnableOption "Alacritty";
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova.rum.programs.alacritty = {
      enable = true;
      settings = {
        font = {
          inherit (fonts) size;
          normal.family = "${fonts.monospace.name}";
        };
        window = {
          dimensions = {
            lines = 28;
            columns = 101;
          };
          padding = {
            x = 6;
            y = 3;
          };
        };
        colors = {
          bright = {
            black = "${colors.base00}";
            blue = "${colors.base0D}";
            cyan = "${colors.base0C}";
            green = "${colors.base0B}";
            magenta = "${colors.base0E}";
            red = "${colors.base08}";
            white = "${colors.base06}";
            yellow = "${colors.base09}";
          };
          cursor = {
            cursor = "${colors.base06}";
            text = "${colors.base06}";
          };
          normal = {
            black = "${colors.base00}";
            blue = "${colors.base0D}";
            cyan = "${colors.base0C}";
            green = "${colors.base0B}";
            magenta = "${colors.base0E}";
            red = "${colors.base08}";
            white = "${colors.base06}";
            yellow = "${colors.base0A}";
          };
          primary = {
            background = "${colors.base00}";
            foreground = "${colors.base06}";
          };
        };
      };
    };

    /*
      hjem.users.lunarnova = {
      packages = with pkgs; [alacritty];
      files.".config/alacritty/alacritty.toml".source = toTOML "alacritty config" {
        font = {
          size = fonts.size;
          normal.family = "${fonts.monospace}";
        };
        window = {
          dimensions = {
            lines = 28;
            columns = 101;
          };
          padding = {
            x = 6;
            y = 3;
          };
        };
        colors = {
          bright = {
            black = "0x${colors.base00}";
            blue = "0x${colors.base0D}";
            cyan = "0x${colors.base0C}";
            green = "0x${colors.base0B}";
            magenta = "0x${colors.base0E}";
            red = "0x${colors.base08}";
            white = "0x${colors.base06}";
            yellow = "0x${colors.base09}";
          };
          cursor = {
            cursor = "0x${colors.base06}";
            text = "0x${colors.base06}";
          };
          normal = {
            black = "0x${colors.base00}";
            blue = "0x${colors.base0D}";
            cyan = "0x${colors.base0C}";
            green = "0x${colors.base0B}";
            magenta = "0x${colors.base0E}";
            red = "0x${colors.base08}";
            white = "0x${colors.base06}";
            yellow = "0x${colors.base0A}";
          };
          primary = {
            background = "0x${colors.base00}";
            foreground = "0x${colors.base06}";
          };
        };
      };
    };
    */
  };
}
