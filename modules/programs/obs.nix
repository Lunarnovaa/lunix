{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.lists) singleton;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.programs.obs;
in {
  options = {
    lunix.programs.obs = {
      enable = mkEnableOption "Open Broadcast Software";
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = singleton (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs #for screen capture w/wayland, will be mandatory in future
          obs-vkcapture #vulkan/opengl game capture #ref https://github.com/nowrep/obs-vkcapture for game setup
          input-overlay #kb, contr, & mouse input
          obs-multi-rtmp #multi-site broadcast
          obs-mute-filter #improves muting capability for sources
          obs-livesplit-one #livesplit one source
          obs-pipewire-audio-capture
        ];
      });
      xdg.config.files = {
        "obs-studio/themes/Catppuccin.obt".source = "${inputs/catppuccin-obs}/themes/Catppuccin.obt";
        "obs-studio/themes/Catppuccin_Mocha.ovt".source = "${inputs/catppuccin-obs}/themes/Catppuccin_mocha.ovt";
      };
    };
  };
}
