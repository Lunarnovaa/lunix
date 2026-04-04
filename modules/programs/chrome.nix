{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.programs.google-chrome;
in {
  options = {
    lunix.progams.google-chrome = {
      enable = mkEnableOption "Google Chrome" // {default = true;};
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.google-chrome];
  };
}
