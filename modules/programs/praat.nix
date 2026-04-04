{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.programs.praat;
in {
  options = {
    lunix.progams.praat = {
      enable = mkEnableOption "Praat";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.praat];
  };
}
