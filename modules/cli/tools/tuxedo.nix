{
  pkgs,
  inputs,
  config,
  ...
}: {
  environment.systemPackages = [pkgs.tuxedo];
  hjem.users.lunarnova.xdg.config.files."tuxedo/themes/catppuccin-mocha.toml".source = "${inputs.tuxedo}/docs/themes/catppuccin-mocha.toml";
  lunix.environment.sessionVariables.TODO_DIR = "${config.hjem.users.lunarnova.directory}/Projects";
}
