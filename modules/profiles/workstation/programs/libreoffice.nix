{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfgWorkstation = config.lunix.profiles.workstation;
  cfg = config.lunix.programs.libreoffice;
in {
  options = {
    lunix.programs.libreoffice = {
      enable =
        mkEnableOption "Libreoffice Suite"
        // {
          default = cfgWorkstation.enable;
          defaultText = "config.lunix.profiles.workstation.enable";
        };
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = [pkgs.libreoffice];
    };
  };
}
