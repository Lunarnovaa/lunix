{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.lunix.profiles.gaming;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      heroic
      gale
      faugus-launcher

      prismlauncher
      dwarf-fortress

      inputs.duck-game-rebuilt.packages."x86_64-linux".default
    ];
  };
}
