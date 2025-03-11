{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (builtins) readFile;

  firefox-csshacks = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "91efcba213560eeaa67812672c60b9137e222676";
    hash = "sha256-+psMiy3WFkYDL7HI5KBKU5b+r9qxudytkYlmqGNJS3o=";
  };
  
  cfg = config.firefox;
in {
  hjem.users.lunarnova.programs.schizofox = mkIf (cfg.enable && (cfg.app == "schizofox") && cfg.verticalTabs) {
    theme.extraUserChrome = 
      readFile "${firefox-csshacks}/chrome/window_control_placeholder_support.css" 
      + readFile "${firefox-csshacks}/chrome/hide_tabs_toolbar.css";
  };
}
