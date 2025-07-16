{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (builtins) concatMap;
  inherit (lib.lists) singleton optionals;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (lib.strings) escapeShellArgs;

  timeouts = [
    {
      timeout = 120;
      command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 1";
      resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
    }
    {
      timeout = 300;
      command = "${pkgs.swaylock}/bin/swaylock -f";
    }
    {
      timeout = 1200;
      command = "systemctl suspend";
    }
  ];
  events = singleton {
    event = "before-sleep";
    command = "${pkgs.swaylock}/bin/swaylock -f";
  };

  # Mostly taken from Home Manager, available under MIT License
  swayidleArgs = escapeShellArgs (
    (concatMap (
        attrset:
          [
            "timeout"
            (toString attrset.timeout)
            attrset.command
          ]
          ++ optionals ((attrset.resume or null) != null) [
            "resume"
            attrset.resume
          ]
      )
      timeouts)
    ++ (concatMap (
        attrset: [
          attrset.event
          attrset.command
        ]
      )
      events)
  );
  # End of MIT License

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
        Environment = ["PATH=${pkgs.bash}/bin/bash"];
        ExecStart = "${pkgs.swayidle}/bin/swayidle -w ${swayidleArgs}";
        Restart = "on-failure";
      };
    };
  };
}
