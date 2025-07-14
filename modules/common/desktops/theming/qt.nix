{pkgs, ...}: let
  envVars = {
    QT_STYLE_OVERRIDE = "Catppuccin-Mocha-Dark";
    QT_QPA_PLATFORMTHEME = "gtk";
  };
in {
  environment.variables = envVars;
  hjem.users.lunarnova = {
    packages = [
      (pkgs.catppuccin-kde.override {
        flavour = ["mocha"];
        accents = ["pink"];
      })
    ];
    environment.sessionVariables = envVars;
  };
}
