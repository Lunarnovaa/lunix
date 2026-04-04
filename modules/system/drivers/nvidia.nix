{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.hardware.nvidia;
in {
  options = {
    lunix.hardware.nvidia = {
      enable = mkEnableOption "nvidia modules";
    };
  };
  config = mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production;

      modesetting.enable = true;
      nvidiaSettings = true; #accessible via nvidia-settings
      open = false; #suspend issues

      powerManagement.enable = true;
    };
    boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  };
}
