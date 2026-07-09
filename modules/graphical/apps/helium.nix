{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.programs.helium;
in {
  options = {
    lunix.programs.helium = {
      enable = mkEnableOption "Helium";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [inputs.helium.packages."x86_64-linux".default];
  };
}
