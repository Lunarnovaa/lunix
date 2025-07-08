{
  inputs',
  inputs,
  ...
}: {
  imports = [inputs.hjem.nixosModules.default];

  # Define the User
  users.users.lunarnova = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  # Setup hjem
  hjem = {
    extraModules = [inputs.hjem-rum.hjemModules.default];
    linker = inputs'.hjem.packages.smfh;
    users.lunarnova = {
      enable = true;
      directory = "/home/lunarnova";
      user = "lunarnova";
    };
  };
}
