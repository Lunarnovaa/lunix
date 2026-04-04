{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.lunix.hardware.display) width height;
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf mkForce;
  inherit (lib.options) mkEnableOption;
  inherit (lib.strings) concatStringsSep;

  args = {
    gamescope = ["-W ${width}" "-H ${height}" "-f" "--steam" "--xwayland-count 2"];
    steam = ["-pipewire-dmabuf" "-gamepadui"];
  };

  cfg = config.lunix.desktops.steam-session;
in {
  options = {
    lunix.desktops.steam-session = {
      enable = mkEnableOption "Steam gamescope session";
    };
  };

  config = mkIf cfg.enable {
    services = {
      xserver.enable = false;
      getty.autologinUser = "lunarnova";
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${getExe pkgs.gamescope} ${concatStringsSep " " args.gamescope} -- steam ${concatStringsSep " " args.steam} > /dev/null 2>&1";
            user = "lunarnova";
          };
        };
      };
    };
    lunix.profiles.gaming.enable = mkForce true;
    programs.steam.gamescopeSession = {
      enable = true;
      args = args.gamescope;
      steamArgs = args.steam;
      env = config.lunix.environment.sessionVariables;
    };
  };
}
