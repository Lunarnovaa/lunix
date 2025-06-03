{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.desktops.niri;
in {
  config = mkIf cfg.enable {
    programs.niri.enable = true;
  };
}
