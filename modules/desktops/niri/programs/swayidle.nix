{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;

  cfgNiri = config.lunix.desktops.niri;
  cfg = config.lunix.services.swayidle;
in {
  options = {
    lunix.services.swayidle = {
      enable =
        mkEnableOption "swayidle"
        // {
          default = cfgNiri.enable;
          defaultText = "config.lunix.desktops.niri.enable";
        };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.swayidle = let
      target = ["graphical-session.target"];
    in {
      description = "Idle manager for Wayland";
      wantedBy = ["niri.service"];
      partOf = target;
      after = target;
      requisite = target;
      serviceConfig = {
        ExecStart =
          # sh
          ''
            ${pkgs.swayidle}/bin/swayidle -w \
              timeout 120 '${pkgs.brightnessctl}/bin/brightnessctl -s set 11' \
                resume '${pkgs.brightnessctl}/bin/brightnessctl -r' \
              timeout 300 '${pkgs.swaylock}/bin/swaylock' \
              timeout 1200 'systemctl suspend' \
              before-sleep '${pkgs.swaylock}/bin/swaylock'
          '';
        Restart = "on-failure";
      };
    };
  };
}
