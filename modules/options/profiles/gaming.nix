{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;

  cfg = config.profiles.gaming;
in {
  options.profiles.gaming = {
    enable = mkEnableOption ''
      the gaming modules. By default, this enables special
      driver and DE configuration related to gaming, and enables
      apps related to gaming.
    '';
    vr.enable = mkEnableOption "VR modules";
    programs = {
      heroic.enable = mkEnableOption "Heroic Games Launcher" // {default = cfg.enable;};
      lutris.enable = mkEnableOption "Lutris" // {default = cfg.enable;};
      minecraft.enable = mkEnableOption "Minecraft, using the Prism Launcher" // {default = cfg.enable;};
      obs.enable = mkEnableOption "Open Broadcast Studio";
      steam.enable = mkEnableOption "Steam" // {default = cfg.enable;};
    };
  };
}
