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

  /*
  My impermanence setup is taken from NotAShelf's blogpost on it, as well as some of
  his impermanence configuration in his now archived Nyx.
  Following his lead, I do not use home impermanence as the state of home is more a matter
  of maintenance as opposed to a need for resets, and having a separate, persistent home
  environment feels unnecessarily nebulous.
  */
  config = mkIf cfg.enable {
    users = {
      # We make it so that users cannot be modified imperatively - only declaratively
      # For NixOS, mostly, this doesn't have any notable consequences except that we
      # must now provide a password declaratively
      mutableUsers = false;

      # After confirming /persist/passwords exist we generate hashed password files with
      # mkpasswd -m sha-512 > /persist/passwords/lunarnova
      # If a user does not have a hashed password, they will not be able to login
      users = {
        root.hashedPasswordFile = "/persist/passwords/root";
        lunarnova.hashedPasswordFile = "/persist/passwords/lunarnova";
      };
    };
    boot.initrd.systemd = {
      enable = true; # enable systemd support in stage1
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
        "/etc/iwd"
        "/etc/NetworkManager/system-connections"
        "/etc/secureboot"
        "/var/db/sudo"
        "/var/lib/iwd"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/pipewire"
        "/var/lib/systemd/coredump"
        "/var/lib/sddm"
        "/var/lib/fprint"
      ];
      files = [
        "/etc/machine-id"
      ];
    };
    services.openssh = {
      enable = true;
      hostKeys = [
        {
          bits = 4096;
          path = "/persist/etc/ssh/ssh_host_rsa_key";
          type = "rsa";
        }
        {
          bits = 4096;
          path = "/persist/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
  };
}
