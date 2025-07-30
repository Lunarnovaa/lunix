{pkgs, ...}: {
  lunix.environment.sessionVariables = {
    QT_STYLE_OVERRIDE = "Catppuccin-Mocha-Dark";
    QT_QPA_PLATFORMTHEME = "gtk";
  };
  hjem.users.lunarnova = {
    packages = [
      (pkgs.catppuccin-kde.override {
        flavour = ["mocha"];
        accents = ["pink"];
      })
    ];
  };
}
