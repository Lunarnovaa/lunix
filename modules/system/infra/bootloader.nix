{
  config,
  lib,
  ...
}: let
  inherit (builtins) substring;
  inherit (lib.strings) toUpper;
  inherit (config.networking) hostName;

  capitalizeName = name:
    (toUpper (substring 0 1 name)) # Take uppercased first char
    + (substring 1 (-1) name); # Add rest of str
in {
  # Configure the Bootloader
  config = {
    boot.loader = {
      limine = {
        enable = true;
        style = {
          wallpapers = [../../../assets/catppuccin-hollow-knight.jpg];
          interface = {
            resolution = "1920x1080"; # 2560x1440 wasn't working, so we're just gonna use this, it works for now.
            branding = "Lunix: Booting into ${capitalizeName hostName}.";
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
