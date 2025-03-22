{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.profiles.gaming.programs.lutris;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.lutris];
  };
}
