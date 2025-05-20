{inputs', ...}: {
  environment.systemPackages = [inputs'.novavim.packages.default];
  environment.variables.EDITOR = "nvim";
  hjem.users.lunarnova.environment.sessionVariables.EDITOR = "nvim";
}
