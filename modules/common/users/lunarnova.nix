{
  inputs',
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) attrsOf str;

  cfg = config.lunix.environment;
in {
  imports = [inputs.hjem.nixosModules.default];

  options = {
    lunix.environment.sessionVariables = mkOption {
      type = attrsOf str;
      default = {};
      example = {
        NIXOS_OZONE_WL = "1";
      };
      description = "A set of session variables applied to system and user profiles.";
    };
  };

  config = {
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
        environment.sessionVariables = cfg.sessionVariables;
      };
    };
    environment.sessionVariables = cfg.sessionVariables;
  };
}
