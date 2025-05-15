{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.lists) singleton;
in {
  config = {
    systemd.services.nh-update = {
      description = "NixOS Update using NH";

      restartIfChanged = false;
      unitConfig.X-StopOnRemoval = false;

      servicesConfig.Type = "oneshot";

      environment = config.nix.envVars;

      path = with pkgs; [
        nh
      ];

      script = ''
        alcritty -e (nh os boot ${config.nh.flake} --update --ask)
      '';

      startAt = "daily";

      after = ["network-online.target"];
      wants = ["network-online.target"];
    };

    systemd.timers.nh-update = {
      Persistent = true;
    };

    nix.optimise = {
      automatic = true;
      dates = singleton "08:00";
    };
  };
}
