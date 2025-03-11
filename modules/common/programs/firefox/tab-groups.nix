{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (builtins) toJSON;

  cfg = config.firefox;
in {
  config = mkIf (cfg.enable && (cfg.app == "mozilla") && (! cfg.verticalTabs)) {
    hjem.users.lunarnova.files.".mozilla/firefox/distribution/policies.json".text = toJSON {
      policies.preferences."browser.tabs.groups.enable" = true;
    };
  };
}
