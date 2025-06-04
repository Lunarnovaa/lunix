{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.lunix.programs.vial;
in {
  options = {
    lunix.programs.vial = {
      enable = mkEnableOption "vial";
      package = mkPackageOption pkgs "vial" {};
    };
  };

  config = mkIf cfg.enable {
    services.udev.packages = [cfg.package];
    environment.systemPackages = [cfg.package];

    /*
    NOTE FOR FUTURE SELF
    holy fucking christ shit I HATE THIS
    I spent hours trying to FIGURE OUT WHY IT WASNT WORKING
    here it is.
    For K6 PRO:
    Download json from keychron website for via shit
    on vial, go to File->Sideload via JSON and select the downloaded file
    NOW UNPLUG THE DAMN KEYBAORD
    PLUG IT BACK IN.
    NOW IT WORKS.
    */
  };
}
