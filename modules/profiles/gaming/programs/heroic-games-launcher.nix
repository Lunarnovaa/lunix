{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.profiles.gaming.programs.heroic;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.heroic];
  };
}
