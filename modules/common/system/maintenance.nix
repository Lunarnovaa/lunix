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

      serviceConfig.Type = "oneshot";

      environment = config.nix.envVars;

      path = with pkgs; [
        nh
        alacritty
      ];

      script = let
        alacritty = "${pkgs.alacritty}/bin/alacritty";
        nh = "${pkgs.nh}/bin/nh";
      in ''
        ${alacritty} -e ${nh} os boot ${config.programs.nh.flake} --update --ask
      '';

      startAt = "daily";

      after = ["network-online.target"];
      wants = ["network-online.target"];
    };

    systemd.timers.nh-update = {
      timerConfig.Persistent = true;
    };

    nix.optimise = {
      automatic = true;
      dates = singleton "08:00";
    };
  };
}
