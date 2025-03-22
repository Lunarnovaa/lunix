{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (builtins) toJSON;

  cfg = config.profiles.gaming;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = [pkgs.element-desktop];
      files.".config/Element/config.json".text = toJSON {
        "setting_defaults" = {
          "custom_themes" = [
            {
              "name" = "Catppuccin Mocha";
              "is_dark" = true;
              "colors" = {
                "accent-color" = "#b4befe";
                "primary-color" = "#b4befe";
                "warning-color" = "#f38ba8";
                "alert" = "#f9e2af";
                "sidebar-color" = "#11111b";
                "roomlist-background-color" = "#181825";
                "roomlist-text-color" = "#cdd6f4";
                "roomlist-text-secondary-color" = "#9399b2";
                "roomlist-highlights-color" = "#45475a";
                "roomlist-separator-color" = "#7f849c";
                "timeline-background-color" = "#1e1e2e";
                "timeline-text-color" = "#cdd6f4";
                "secondary-content" = "#cdd6f4";
                "tertiary-content" = "#cdd6f4";
                "timeline-text-secondary-color" = "#a6adc8";
                "timeline-highlights-color" = "#181825";
                "reaction-row-button-selected-bg-color" = "#45475a";
                "menu-selected-color" = "#45475a";
                "focus-bg-color" = "#585b70";
                "room-highlight-color" = "#89dceb";
                "togglesw-off-color" = "#9399b2";
                "other-user-pill-bg-color" = "#89dceb";
                "username-colors" = [
                  "#cba6f7"
                  "#eba0ac"
                  "#fab387"
                  "#a6e3a1"
                  "#94e2d5"
                  "#89dceb"
                  "#74c7ec"
                  "#b4befe"
                ];
                "avatar-background-colors" = [
                  "#89b4fa"
                  "#cba6f7"
                  "#a6e3a1"
                ];
              };
            }
          ];
        };
      };
    };
  };
}
