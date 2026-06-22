{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;

  cfg = config.lunix.desktops.cosmic;
in {
  options = {
    lunix.desktops.cosmic.enable = mkEnableOption "COSMIC Desktop Environment" // {default = true;};
  };

  config = mkIf cfg.enable {
    services = {
      displayManager.cosmic-greeter.enable = true;
      desktopManager.cosmic.enable = true;
    };
  };
}
