{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) str;

  cfg = config.lunix.hardware.display;
in {
  options = {
    lunix.hardware.display = {
      resolution = mkOption {
        type = str;
        default = "1920x1080";
        example = "2560x1440";
        description = "The resolution of the display.";
      };
    };
  };

  # Configure the Bootloader
  config = {
    boot.loader = {
      limine = {
        enable = true;
        style = {
          wallpapers = [../../../assets/catppuccin-hollow-knight.jpg];
          interface = {
            inherit (cfg) resolution;
            branding = "Lunix: Booting into ${config.networking.hostName}.";
          };
        };
        extraConfig = ''
          # catppuccin-mocha-pink from catppuccin/limine
          term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
          term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
          term_background: 091e1e2e # 0.9 transparency
          term_foreground: cdd6f4
          term_background_bright: 09585b70
          term_foreground_bright: cdd6f4
          interface_branding_color: f5c2e7
          interface_help_color: f5c2e7
          interface_help_color_bright: f5c2e7
        '';
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };
}
