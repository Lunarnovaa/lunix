{
  pkgs,
  config,
  ...
}: let
  inherit (config.lunix.theme) fonts;

  fallbackPackages = [
    pkgs.corefonts
    pkgs.vista-fonts
  ];
  fallbackFonts = [
    "corefonts"
    "vistafonts"
  ];
in {
  fonts = {
    enableDefaultPackages = false;
    packages =
      [
        fonts.monospace.package
        fonts.sans.package
        fonts.serif.package
        fonts.emoji.package
        fonts.cjk-sans.package
        fonts.cjk-serif.package
      ]
      ++ fallbackPackages;
    fontconfig = {
      defaultFonts = {
        serif =
          [
            fonts.serif.name
            fonts.cjk-serif.name
          ]
          ++ fallbackFonts;
        sansSerif =
          [
            fonts.sans.name
            fonts.cjk-sans.name
          ]
          ++ fallbackFonts;
        monospace =
          [
            fonts.monospace.name
            fonts.cjk-serif.name
          ]
          ++ fallbackFonts;
        emoji = [
          fonts.emoji.name
        ];
      };
    };
  };
}
