{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkDefault mkIf;

  cfg = config.profiles.gaming;
in {
  options.profiles.gaming = {
    enable = mkEnableOption ''
      the gaming modules. By default, this enables special
      driver and DE configuration related to gaming, and enables
      apps related to gaming.
    '';
    vr.enable = mkEnableOption ''
      VR.
    ''; # VR is not enabled by default.
    programs = {
      heroic.enable = mkEnableOption ''
        Heroic Games Launcher, for Epic Games.
      '';
      lutris.enable = mkEnableOption ''
        Lutris.
      '';
      minecraft.enable = mkEnableOption ''
        Minecraft, installing Prism-Launcher.
      '';
      obs.enable = mkEnableOption ''
        "Open Broadcast Software."
      ''; # OBS is not enabled by default.
      steam.enable = mkEnableOption ''
        Steam.
      '';
    };
  };
  config = mkIf cfg.enable {
    profiles.gaming.programs = {
      heroic.enable = mkDefault true;
      lutris.enable = mkDefault true;
      minecraft.enable = mkDefault true;
      steam.enable = mkDefault true;
    };
  };
}
