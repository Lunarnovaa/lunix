{
  pkgs,
  config,
  options,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;

  catppuccin-prism-launcher = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "prismlauncher";
    rev = "2edbdf5295bc3c12c3dd53b203ab91028fce2c54";
    hash = "sha256-+yGrSZztf2sZ9frPT3ydIJDavo4eXs03cQWfdTAmn3w=";
  };

  cfg = config.lunix.profiles.gaming;
in {
  options = {
    lunix.profiles.gaming = {
      enable = mkEnableOption "Gaming Programs and Games";
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      beyond-all-reason

      bottles
      heroic
      lutris
      prismlauncher
      protonup-ng
    ];
    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        #extest.enable = true;
      };
      gamescope = {
        enable = true;
        capSysNice = true;
      };
    };
    lunix.environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/lunarnova/.steam/root/compatibilitytools.d";
    hardware.steam-hardware.enable = true;
    hjem.users.lunarnova.files = {
      ".local/share/PrismLauncher/themes/catppuccin-mocha/theme.json".source = "${catppuccin-prism-launcher}/themes/Mocha/theme.json";
      ".local/share/PrismLauncher/themes/catppuccin-mocha/themeStyle.css".source = "${catppuccin-prism-launcher}/themes/Mocha/themeStyle.css";
    };
  };
}
