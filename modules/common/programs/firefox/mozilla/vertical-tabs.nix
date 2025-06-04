{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (builtins) toJSON readFile;

  firefox-csshacks = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "91efcba213560eeaa67812672c60b9137e222676";
    hash = "sha256-+psMiy3WFkYDL7HI5KBKU5b+r9qxudytkYlmqGNJS3o=";
  };

  cfg = config.lunix.programs.firefox;
in {
  config = mkIf (cfg.enable && (cfg.app == "mozilla") && cfg.verticalTabs) {
    hjem.users.lunarnova.files = {
      ".mozilla/firefox/distribution/policies.json".text = toJSON {
        policies.preferences = {
          "sidebar.verticalTabs" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
      ".mozilla/firefox/lunarnova/chrome/userChrome.css".source = (
        readFile "${firefox-csshacks}/chrome/window_control_placeholder_support.css"
        + readFile "${firefox-csshacks}/chrome/hide_tabs_toolbar.css"
      );
    };
  };
}
