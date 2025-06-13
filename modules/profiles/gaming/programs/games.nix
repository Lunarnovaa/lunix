{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfgGaming = config.lunix.profiles.gaming;
  cfg = config.lunix.programs.games;
in {
  options = {
    lunix.programs.games = {
      enable =
        mkEnableOption "free and open source games packaged in Nix"
        // {
          default = cfgGaming.enable;
          defaultText = "config.lunix.profiles.gaming.enable";
        };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      beyond-all-reason
      unciv
    ];
  };
}
