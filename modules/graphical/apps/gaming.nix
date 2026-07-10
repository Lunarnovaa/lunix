{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;

  cfg = config.lunix.profiles.gaming;
in {
  options = {
    lunix.profiles.gaming = {
      enable = mkEnableOption "Gaming Programs and Games";
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      heroic
      gale
      prismlauncher
      protonup-rs
    ];
    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        extraPackages = [pkgs.hidapi];
        extest.enable = true;
        # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        extraCompatPackages = [pkgs.proton-ge-bin];
      };
      gamescope = {
        enable = true;
        capSysNice = true;
      };
    };
    lunix.environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/lunarnova/.steam/root/compatibilitytools.d";
    hardware.steam-hardware.enable = true;
    hjem.users.lunarnova.xdg.data.files."PrismLauncher/themes/catppuccin-mocha-pink".source = "${inputs.catppuccin-prismlauncher}/themes/mocha/pink";
  };
}
