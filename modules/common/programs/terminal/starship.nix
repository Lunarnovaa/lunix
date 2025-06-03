{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  nuCfg = config.terminal.apps.nushell;
  #fishCfg = config.terminal.apps.fish;
  cfg = config.terminal.apps.starship;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova.rum.programs.starship = {
      enable = true;
      integrations.nushell.enable = nuCfg.enable;
    };
  };
}
