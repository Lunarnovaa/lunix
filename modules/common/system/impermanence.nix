{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.hardware.impermanence;
in {
  imports = [inputs.impermanence.nixosModules.default];

  options = {
    lunix.hardware.impermanence = {
      enable = mkEnableOption "root impermanence";
    };
  };

  config = mkIf cfg.enable {
    boot.initrd.systemd = {
      enable = false; # enable systemd support in stage1
      services.rollback = {
        description = "Rollback BTRFS root subvolume to a pristine state";
        wantedBy = ["initrd.target"];

        # LUKS/TPM process
        after = ["systemd-cryptsetup@enc.service"];

        # Before mounting the system root (/sysroot) during early boot process
        before = ["sysroot.mount"];

        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          mkdir -p /mnt

          # We first mount the BTRFS root to /mnt so we can manipulate btrfs subvols
          mount -o subvol=/ /dev/mapper/enc /mnt

          # Rather than just replacing /root with /root-blank, we must remove the
          # subvolumes under /root first:
          # - /root/var/lib/portables
          # - /root/var/lib/machines

          btrfs subvolume list -o /mnt/root |
            cut -f9 -d' ' |
            while read subvolume; do
              echo "deleting /$subvolume subvolume..."
              btrfs subvolume delete "/mnt/$subvolume"
            done &&
            echo "deleting /root subvolume..." &&
            btrfs subvolume delete /mnt/root
          echo "restoring blank /root subvolume..."
          btrfs subvolume snapshot /mnt/root-blank /mnt/root

          # Once done rolling back, we can simply unmount /mnt and continue booting.
          umount /mnt
        '';
      };
    };
    environment.persistence."/persist" = {
      directories = [
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
        "/etc/secureboot"
        "/var/db/sudo"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/pipewire"
        "/var/lib/systemd/coredump"
      ];
      files = [
        "/etc/machine-id"

        # Required for SSH
        "/etc/ssh/ssh-host_ed25519_key"
        "/etc/ssh/ssh-host_ed25519_key.pub"
        "/etc/ssh/ssh-host_rsa_key"
        "/etc/ssh/ssh-host_rsa_key.pub"
      ];
    };
  };
}
