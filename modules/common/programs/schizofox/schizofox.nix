{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.firefox;
in {
  imports = [
    inputs.schizofox.nixosModule
  ];

  config = mkIf (cfg.enable && (cfg.app == "schizofox")) {
    hjem.users.lunarnova.programs.schizofox = {
      enable = true;
      misc = {
        displayBookmarksInToolbar = "always";
        firefoxSync = true;
      };
      search.defaultSearchEngine = "DuckDuckGo";
    };
  };
}
