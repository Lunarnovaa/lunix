{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;

  cfg = config.lunix.displayManagers.cosmic-greeter;
in {
  options = {
    lunix.displayManagers.cosmic-greeter = {
      enable = mkEnableOption "cosmic-greeter";
    };
  };

  config = mkIf cfg.enable {
    services.displayManager.cosmic-greeter.enable = true;
  };
}
