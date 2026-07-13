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
    lunix.environment.sessionVariables.DEFAULT_BROWSER = "helium";
    hjem.users.lunarnova.xdg.mime-apps.default-applications = {
      "text/html" = ["helium"];
      "x-scheme-handler/http" = ["helium"];
      "x-scheme-handler/https" = ["helium"];
      "x-scheme-handler/about" = ["helium"];
      "x-scheme-handler/unknown" = ["helium"];
    };
  };
}
