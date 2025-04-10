{pkgs, ...}: {
  environment.variables.QT_STYLE_OVERRIDE = "Catppuccin-Mocha-Dark";

  hjem.users.lunarnova.packages = [
    (pkgs.catppuccin-kde.override {
      flavour = ["mocha"];
      accents = ["rosewater"];
    })
  ];
}
