{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.programs.obsidian;
in {
  options = {
    lunix.programs.obsidian = {
      enable = mkEnableOption "Obsidian Markdown Editor";
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = [pkgs.obsidian];
    };
  };
}
