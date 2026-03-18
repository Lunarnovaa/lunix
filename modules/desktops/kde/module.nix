{
  lib,
  config,
  ...
}: let
inherit (lib.modules) mkIf mkDefault;
inherit (lib.options) mkEnableOption;

cfg = config.lunix.desktops.kde;
in {
options = {
  lunix.desktops.kde = {
    enable = mkEnableOption "KDE Plasma Desktop Environment";
  };
};

config = mkIf cfg.enable {
  # Enable Plasma
  services.desktopManager.plasma6.enable = true;
};
}
