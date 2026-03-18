{
  config,
  pkgs,
  lib,
  theme,
  ...
}: let
  inherit (lib.lists) singleton;
  inherit (lib.modules) mkIf mkForce;
  inherit (lib.options) mkEnableOption;
  inherit (theme) fonts wallpapers;

  cfg = config.lunix.displayManagers.plasma-login-manager;
in {
  options = {
    lunix.displayManagers.plasma-login-manager = {
      enable = mkEnableOption "Plasma Login Manager";
    };
  };

  config = mkIf cfg.enable {
    services.displayManager.plasma-login-manager = {
      enable = true;
    };  };
}
