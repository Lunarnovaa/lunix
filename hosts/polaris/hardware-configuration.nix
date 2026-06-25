{
  config,
  lib,
  modulesPath,
  ...
}: let
  inherit (lib.lists) singleton;
  inherit (lib.modules) mkDefault;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/2977e5cd-6c46-42b8-abc7-6ac1afb1d000";
      fsType = "btrfs";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/2977e5cd-6c46-42b8-abc7-6ac1afb1d000";
      fsType = "btrfs";
      options = ["subvol=home"];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/2977e5cd-6c46-42b8-abc7-6ac1afb1d000";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/7AEA-F54F";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    "/games" = {
      device = "/dev/disk/by-uuid/2daf90cc-5967-4424-aee1-1a5869f99ef3";
      fsType = "ext4";
      options = ["nofail"];
    };
  };

  swapDevices = singleton {
    device = "/dev/disk/by-uuid/7490b6e6-f445-4840-ae62-46425c0692ba";
  };

  nixpkgs.hostPlatform = mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
}
