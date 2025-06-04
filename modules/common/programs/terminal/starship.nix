{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfgNu = config.lunix.programs.nushell;
  cfg = config.lunix.programs.starship;
in {
  options = {
    lunix.programs.starship = {
      enable = mkEnableOption "starship" // {default = true;};
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova.rum.programs.starship = {
      enable = true;
      integrations.nushell.enable = cfgNu.enable;
    };
  };
}
