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

  cfg = config.lunix.displayManagers.sddm;
in {
  options = {
    lunix.displayManagers.sddm = {
      enable = mkEnableOption "SDDM";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = singleton (
      pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        accent = "pink";
        font = "${fonts.monospace.name}";
        fontSize = "12";
        # background = "${wallpapers.primary}";
        # loginBackground = true;
        #userIcon = true;
      }
    );
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = mkForce pkgs.kdePackages.sddm;
    };
  };
}
