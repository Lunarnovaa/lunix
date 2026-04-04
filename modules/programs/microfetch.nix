{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;

  cfg = config.lunix.programs.microfetch;
in {
  options = {
    lunix.programs.microfetch = {
      enable = mkEnableOption "Microfetch" // {default = true;};
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.microfetch];
  };
}
