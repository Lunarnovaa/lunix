{inputs', ...}: {
  environment.systemPackages = [inputs'.novavim.packages.default];
}
