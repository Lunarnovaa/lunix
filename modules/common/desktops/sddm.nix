{
  config,
  pkgs,
  lib,
  theme,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  inherit (theme) fonts wallpapers;

  cfg = config.desktops;
in {
  config = mkIf (cfg.kde.enable || cfg.hyprland.enable) {
    environment.systemPackages = [
      (
        pkgs.catppuccin-sddm.override {
          flavor = "mocha";
          font = "${fonts.monospace.name}";
          fontSize = "11";
          background = "${wallpapers.primary}"; # for some reason, this doesn't work rn
          loginBackground = true;
        }
      )
    ];
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      package = mkForce pkgs.kdePackages.sddm;
    };
  };
}
