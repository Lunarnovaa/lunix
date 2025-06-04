{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  catppuccin-prism-launcher = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "prismlauncher";
    rev = "2edbdf5295bc3c12c3dd53b203ab91028fce2c54";
    hash = "sha256-+yGrSZztf2sZ9frPT3ydIJDavo4eXs03cQWfdTAmn3w=";
  };

  cfgGaming = config.lunix.profiles.gaming;
  cfg = config.lunix.programs.minecraft;
in {
  options = {
    lunix.programs.minecraft = {
      enable = mkEnableOption "Minecraft with Prism-Launcher" // {default = cfgGaming.enable;};
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = [pkgs.prismlauncher];
      files = {
        ".local/share/PrismLauncher/themes/catppuccin-mocha/theme.json".source = "${catppuccin-prism-launcher}/themes/Mocha/theme.json";
        ".local/share/PrismLauncher/themes/catppuccin-mocha/themeStyle.css".source = "${catppuccin-prism-launcher}/themes/Mocha/themeStyle.css";
      };
    };
  };
}
