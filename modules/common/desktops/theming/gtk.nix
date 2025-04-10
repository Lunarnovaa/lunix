{
  config,
  pkgs,
  theme,
  lib,
  ...
}: let
  inherit (theme) fonts;
  inherit (lib.strings) optionalString;
  inherit (builtins) readFile toString;

  cfg = config.hjem.users.lunarnova.rum.gtk;

  packages = {
    theme = pkgs.catppuccin-gtk.override {
      accents = ["rosewater"];
      variant = "mocha";
      size = "standard";
      tweaks = ["normal"];
    };
    iconTheme = pkgs.catppuccin-papirus-folders.override {
      accent = "rosewater";
      flavor = "mocha";
    };
    cursorTheme = pkgs.bibata-cursors;
  };
in {
  hjem.users.lunarnova.rum.gtk = {
    enable = true;
    packages = [
      packages.theme
      packages.iconTheme
      packages.cursorTheme
    ];
    settings = {
      application-prefer-dark-theme = true;
      theme-name = "catppuccin-mocha-rosewater-standard+normal";
      icon-theme-name = "Papirus-Dark";
      font-name = "${fonts.sans.name} ${toString fonts.size}";
      cursor-theme-name = "Bibata-Modern-Classic";
    };
    css = let
      darkTheme = cfg.settings.application-prefer-dark-theme;
      fileCSS = ver: "${packages.theme}/share/themes/${cfg.settings.theme-name}/gtk-${ver}/gtk${optionalString darkTheme "-dark"}.css";
    in {
      gtk3 = readFile (fileCSS "3.0");
      gtk4 = readFile (fileCSS "4.0");
    };
  };
}
