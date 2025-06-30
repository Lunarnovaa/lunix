{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  inherit (inputs.lunarsLib.generators.ron) toRON mkRON;
  inherit (lib.attrsets) mapAttrs' nameValuePair;
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkEnableOption mkOption literalExpression;
  inherit (lib.types) attrsOf anything;

  mkCosmicFilesSettings = settings:
    mapAttrs' (n: v:
      nameValuePair ".config/cosmic/com.system76.CosmicFiles/v1/${n}" {
        text = toRON 0 v;
      })
    settings;

  cfgNiri = config.lunix.desktops.niri;
  cfg = config.lunix.programs.cosmic-files;
in {
  options = {
    lunix.programs.cosmic-files = {
      enable =
        mkEnableOption "Cosmic Files as a standalone program (for use in Niri)"
        // {
          default = cfgNiri.enable;
          defaultText = "config.lunix.desktops.niri.enable";
        };
      settings = mkOption {
        type = attrsOf anything;
        default = {};
        example = literalExpression ''
          tab = {
            show_hidden = true;
            view = inputs.lunarsLib.generators.ron.mkRON "enum" "Grid";
          };
        '';
        description = ''
          [Cosmic Manager's Documentation]: https://heitoraugustoln.github.io/cosmic-manager/options/index.html?highlight=cosmic-files#programscosmic-filessettings

          The settings for Cosmic Files written to {file}`$HOME/.config/cosmic/com.system76.CosmicFiles/`

          For a complete list of options, see [Cosmic Manager's Documentation].
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = [pkgs.cosmic-files];
      files = mkCosmicFilesSettings cfg.settings;
    };
    lunix.programs.cosmic-files.settings = mkDefault {
      tab = {
        show_hidden = true;
        view = mkRON "enum" "Grid";
      };
      desktop = {
        show_content = false;
      };
    };
  };
}
