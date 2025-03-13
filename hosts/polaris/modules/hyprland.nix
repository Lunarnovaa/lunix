{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  primaryDisplay = "HDMI-A-1";
  secondaryDisplay = "DP-4";
in {
  # Configure hyprland
  hyprland = {
    enable = false;
    smartgaps = true;
    monitors = {
      configuration = [
        "${primaryDisplay}, preferred, auto, 1"
        #"${secondaryDisplay}, preferred, auto-left, 1"
        "${secondaryDisplay}, disable"
      ];
      bind = mkIf config.profiles.gaming.enable [
        #moves firefox workspace to secondary for gaming, primary when done
        #"$mod,B,moveworkspacetomonitor,1 ${secondaryDisplay}"
        #"$mod,K,moveworkspacetomonitor,1 ${primaryDisplay}"
      ];
      rules = [
        #"3, monitor:${primaryDisplay}"
        #"2, monitor:${secondaryDisplay}, default:true"
      ];
    };
  };
}
