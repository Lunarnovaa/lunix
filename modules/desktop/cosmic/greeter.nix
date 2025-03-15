{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.cosmic;
in {
  config = mkIf cfg.enable {
    services.displayManager.cosmic-greeter.enable = true;
  };
}
