{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.lists) optional;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfgGaming = config.lunix.profiles.gaming;
  cfg = config.lunix.programs.games;
in {
  options = {
    lunix.programs.games = {
      beyond-all-reason = {
        enable =
          mkEnableOption "Beyond All Reason"
          // {
            default = cfg.enable;
            defaultText = "config.lunix.programs.games.enable";
          };
      };
      unciv = {
        enable =
          mkEnableOption "Unciv"
          // {
            default = cfg.enable;
            defaultText = "config.lunix.programs.games.enable";
          };
      };
      enable =
        mkEnableOption "free and open source games packaged in Nix"
        // {
          default = cfgGaming.enable;
          defaultText = "config.lunix.profiles.gaming.enable";
        };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      (optional cfg.beyond-all-reason.enable pkgs.beyond-all-reason)
      ++ (optional cfg.unciv.enable pkgs.unciv);
  };
}
