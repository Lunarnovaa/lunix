{
  config,
  pkgs,
  ...
}: {
  config = {
    systemd.services.system-maintenance = {
      description = "Attended Automatic System Maintenance";

      restartIfChanged = false;
      unitConfig.X-StopOnRemoval = false;

      serviceConfig.Type = "oneshot";

      environment = config.nix.envVars;

      path = with pkgs; [
        nh
        alacritty
        nushell
      ];

      script = let
        alacritty = "${pkgs.alacritty}/bin/alacritty";
        nh = "${pkgs.nh}/bin/nh";
        nu = "${pkgs.nushell}/bin/nu";
        nix-store = "${config.nix.package}/bin/nix-store";
      in
        # Couldn't figure out how to feed alacritty multiple programs so I just fed it into nu.
        ''
          ${alacritty} -e ${nu} -c "\
            ${nh} os boot ${config.programs.nh.flake} --update --ask ; \
            ${nh} clean all --keep-since 7d --keep 3 ; \
            ${nix-store} --optimise"
        '';

      startAt = "Mon,Wed,Sat 08:00:00";

      after = ["network-online.target"];
      wants = ["network-online.target"];
    };

    systemd.timers.system-maintenance = {
      timerConfig.Persistent = true; # Will update on next boot after timer went off
    };
  };
}
