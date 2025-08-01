{
  config,
  pkgs,
  theme,
  lib,
  ...
}: let
  inherit (theme) fonts;
  inherit (lib.lists) singleton;
  inherit (lib.strings) optionalString;
  inherit (builtins) readFile toString;

  packages = {
    theme = pkgs.catppuccin-gtk.override {
      accents = ["pink"];
      variant = "mocha";
      size = "standard";
      tweaks = ["normal"];
    };
    iconTheme = pkgs.catppuccin-papirus-folders.override {
      accent = "pink";
      flavor = "mocha";
    };
    cursorTheme = pkgs.bibata-cursors;
  };

  cfg = config.hjem.users.lunarnova.rum.misc.gtk;
in {
  hjem.users.lunarnova.rum.misc.gtk = {
    enable = true;
    packages = [
      packages.theme
      packages.iconTheme
      packages.cursorTheme
    ];
    settings = {
      application-prefer-dark-theme = true;
      theme-name = "catppuccin-mocha-pink-standard+normal";
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
  programs.dconf = {
    enable = true;
    profiles.user.databases = singleton {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          gtk-theme = cfg.settings.theme-name;
          icon-theme = cfg.settings.icon-theme-name;
        };
      };
    };
  };
}
