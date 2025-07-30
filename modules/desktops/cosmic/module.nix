{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (inputs.lunarsLib.generators) mkCosmicSettings;
  inherit (inputs.lunarsLib.importers) listNixRecursive;
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkEnableOption mkOption literalExpression;
  inherit (lib.types) attrsOf anything;

  cfg = config.lunix.desktops.cosmic;
in {
  imports = listNixRecursive ./.;

  options = {
    lunix.desktops.cosmic = {
      enable = mkEnableOption "COSMIC Desktop Environment";
      settings = mkOption {
        type = attrsOf anything;
        default = {};
        example = literalExpression ''
          {
            CosmicTk = {
              interface_font = {
                family = theme.fonts.sans.name;
                weight = mkRON "enum" "Normal";
              };
              monospace_font = {
                family = theme.fonts.monospace.name;
                weight = mkRON "enum" "Normal";
              };
              show_maximize = false;
              show_minimize = false;
            };
          }
        '';
        description = ''
          The settings to convert into RON and recursively write to {file}$HOME/.config/cosmic.
          For more information, please see [Cosmic-Manager's documentation].

          [Cosmic Manager's documenation]: https://heitoraugustoln.github.io/cosmic-manager/options/index.html
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    lunix.displayManagers.cosmic-greeter.enable = mkDefault true;

    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true; # By default this is enabled
    };

    hjem.users.lunarnova.files = mkCosmicSettings cfg.settings;
  };
}
