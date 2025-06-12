{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) enum;

  json = pkgs.formats.json {};

  cfg = config.lunix.programs.firefox;
in {
  options = {
    lunix.programs.firefox = {
      enable = mkEnableOption "Firefox Browser";
      app = mkOption {
        type = enum ["mozilla" "schizofox"];
        default = "mozilla";
        example = "schizofox";
        description = ''
          The app to install and configure Firefox with.
        '';
      };
      settings = {
        vertical-tabs.enable =
          mkEnableOption "vertical tabs in Firefox"
          // {
            default = true;
            example = false;
          };
        policies = mkOption {
          inherit (json) type;
          default = {};
          example = {
            DisableTelemetry = true;
            DisablePocket = true;
            preferences = {
              "sidebar.verticalTabs" = true;
            };
          };
          description = ''
            The policies that will be included with the package derivation
            of Firefox.

            See [policy-templates](https://mozilla.github.io/policy-templates)
            for an exhaustive list of policies.
          '';
        };
      };
    };
  };
  config = mkIf cfg.enable {
    lunix.programs.firefox.settings.policies = {
      SearchEngines.Default = "DuckDuckGo";
      preferences = {
        "sidebar.verticalTabs" = cfg.settings.vertical-tabs.enable;
        "browser.tabs.groups.enable" = true;
      };
    };
  };
}
