{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.programs.vr;
in {
  options = {
    lunix.programs.vr = {
      enable = mkEnableOption "VR modules";
    };
  };

  config = mkIf cfg.enable {
    services.wivrn = {
      enable = true;

      # Opens firewall for wivrn to stream through wifi
      openFirewall = true;

      # Autostarts wivrn daemon
      autoStart = true;

      defaultRuntime = true;

      # fixes crash with nvidia proprietary drivers
      extraPackages = [pkgs.monado-vulkan-layers];

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
