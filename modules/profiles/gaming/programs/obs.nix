{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  catppuccin-mocha = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "obs";
    rev = "3f8af3bf1a1742529259a19d923277786b99e3ef";
    hash = "sha256-+X2ZkteIHVq9eP8yrzAERVp7IC2V9MWfcsJsBb+WBd0=";
  };

  cfg = config.lunix.programs.obs;
in {
  options = {
    lunix.programs.obs = {
      enable = mkEnableOption "Open Broadcast Software";
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      rum.programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs #for screen capture w/wayland, will be mandatory in future
          obs-vkcapture #vulkan/opengl game capture #ref https://github.com/nowrep/obs-vkcapture for game setup
          input-overlay #kb, contr, & mouse input
          obs-multi-rtmp #multi-site broadcast
          obs-mute-filter #improves muting capability for sources
          obs-livesplit-one #livesplit one source
          obs-pipewire-audio-capture
        ];
      };
      files.".config/obs-studio/themes".source = "${catppuccin-mocha}/themes";
    };
  };
}
