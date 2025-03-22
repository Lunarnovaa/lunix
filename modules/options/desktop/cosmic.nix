{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) attrsOf anything;
in {
  options.desktops.cosmic = {
    enable = mkEnableOption "Cosmic Desktop Environment";

    settings = mkOption {
      type = attrsOf anything;
      example = {
        "CosmicTheme.Dark.Builder" = {
          palette = {
            name = "lunartheme";
            bright_red = {
              red = 1.0;
              green = 0.6524;
              blue = 0.5454;
              alpha = 1.0;
            };
          };
          is_frosted = true;
        };
        "CosmicFiles" = {
          tab.show_hidden = true;
        };
      };
      description = ''
      '';
    };
  };
}
