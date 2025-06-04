{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption literalExpression;
  inherit (lib.types) package;

  cfg = config.lunix.hardware.nvidia;
in {
  options = {
    lunix.hardware.nvidia = {
      enable = mkEnableOption "nvidia modules";
      # mkPackageOption unfortunately only works with nixpkgs
      # Additionally, the user may wish to use a custom derivation
      package = mkOption {
        type = package;
        # Use Production Driver by default - Currently 570.124.04
        default = config.boot.kernelPackages.nvidiaPackages.production;
        example = literalExpression "config.boot.kernelPackages.nvidiaPackages.latest";
        description = "The Nvidia driver package to use.";
      };
    };
  };
  config = mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      inherit (cfg) package;

      modesetting.enable = true;
      nvidiaSettings = true; #accessible via nvidia-settings
      open = false; #suspend issues

      powerManagement.enable = true;
    };
    boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  };
}
