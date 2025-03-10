{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.profiles.gaming;
in {
  config = mkIf (cfg.enable && cfg.vr.enable) {
    services.wivrn = {
      enable = true;

      # Opens firewall for wivrn to stream through wifi
      openFirewall = true;

      # Autostarts wivrn daemon
      autoStart = true;

      defaultRuntime = true;

      extraPackages = with pkgs; [
        # fixes crash with nvidia proprietary drivers
        monado-vulkan-layers
      ];

      config = {
        enable = true;
        json = {
          encoders = [
            {
              encoder = "nvenc";
              codec = "h265";
            }
          ];
        };
      };
    };
  };
}
