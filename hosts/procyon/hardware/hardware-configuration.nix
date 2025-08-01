# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: let
  inherit (lib.lists) singleton;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod"];
      kernelModules = [];
      luks.devices."enc".device = "/dev/disk/by-uuid/6f59b641-0730-4a1f-9e01-543932aaf303";
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/c3da71cf-1c23-49c0-a15d-2cd43df8bebd";
      fsType = "btrfs";
      options = [
        "subvol=root"
        "compress=zstd"
        "noatime"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/c3da71cf-1c23-49c0-a15d-2cd43df8bebd";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
    };

    "/persist" = {
      device = "/dev/disk/by-uuid/c3da71cf-1c23-49c0-a15d-2cd43df8bebd";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=persist"
        "compress=zstd"
        "noatime"
      ];
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/c3da71cf-1c23-49c0-a15d-2cd43df8bebd";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "subvol=log"
        "compress=zstd"
        "noatime"
      ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/c3da71cf-1c23-49c0-a15d-2cd43df8bebd";
      fsType = "btrfs";
      options = [
        "subvol=home"
        "compress=zstd"
        "noatime"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/B2B9-3115";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  swapDevices = singleton {
    # We use partuuid for the swap since the uuid and label get randomized
    device = "/dev/disk/by-partuuid/d988f16a-ab52-426b-ad41-964b0ae8dabb";
    randomEncryption = {
      enable = true;
      cipher = "aes-xts-plain64";
      keySize = 256;
      sectorSize = 4096;
    };
  };
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
