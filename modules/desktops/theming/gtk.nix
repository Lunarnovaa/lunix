{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.lunix.theme) fonts;
  inherit (lib.strings) hasPrefix concatStringsSep;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.trivial) boolToString;
  inherit (lib.generators) toINI;
  inherit (builtins) isBool isString toString;

  # These functions are inspired by home-manager's gtk generators. mit license available
  toGtk2Text = let
    formatGtk2 = n: v: let
      n' =
        if hasPrefix "gtk-" n
        then n
        else "gtk-" + n;
      v' =
        if isBool v
        then boolToString v
        else if isString v
        then
          if hasPrefix "GTK_" v
          then v
          else ''"${v}"''
        else toString v;
    in "${n'}=${v'}";
  in
    {settings}: concatStringsSep "\n" (mapAttrsToList formatGtk2 settings);
  toGtkINI = attrs:
    toINI {
      mkKeyValue = n: v: let
        n' =
          if hasPrefix "gtk-" n
          then n
          else "gtk-" + n;
        v' =
          if isBool v
          then boolToString v
          else toString v;
      in "${n'}=${v'}";
    }
    attrs;

  ##########
  ## end of mit license

  gtk-settings = {
    gtk-icon-theme-name = "Papirus-Dark";

    gtk-theme-name = "catppuccin-mocha-pink-standard+normal";

    gtk-font-name = "${fonts.sans.name} 11";

    gtk-cursor-theme-name = "Bibata-Modern-Classic";

    gtk-application-prefer-dark-theme = true;
  };

  gtk-theme-pkg = pkgs.catppuccin-gtk.override {
    accents = ["pink"];
    variant = "mocha";
    size = "standard";
    tweaks = ["normal"];
  };
in {
  hjem.users.lunarnova = {
    files = {
      ".gtkrc-2.0".text = toGtk2Text {settings = gtk-settings;};
      ".config/gtk-3.0/settings.ini".text = toGtkINI {
        Settings = gtk-settings;
      };
      ".config/gtk-4.0/settings.ini".text = toGtkINI {
        Settings = gtk-settings;
      };
      ".config/gtk-4.0/gtk.css".source = "${gtk-theme-pkg}/share/themes/${gtk-settings.gtk-theme-name}/gtk-4.0/gtk-dark.css";
    };
    packages = [
      (pkgs.catppuccin-papirus-folders.override {
        accent = "pink";
        flavor = "mocha";
      })
      pkgs.bibata-cursors
      gtk-theme-pkg
    ];
  };

  environment.sessionVariables = {
    GTK2_RC_FILES = "${config.hjem.users.lunarnova.directory}/.gtkrc-2.0";
    GTK_THEME = "${gtk-settings.gtk-theme-name}";
  };
}
