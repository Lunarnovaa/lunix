{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.sysconf.nvidia {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      # Use Production Driver by default - Currently 570.124.04
      package = config.boot.kernelPackages.nvidiaPackages.production;

      modesetting.enable = true;
      nvidiaSettings = true; #accessible via nvidia-settings
      open = false; #suspend issues

      powerManagement.enable = true;
    };
    boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  };
}
