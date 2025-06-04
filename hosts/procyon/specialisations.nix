{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  # Specialisation for "Gaming Mode": Enables Gaming Module
  config.specialisation = {
    gamingMode.configuration = {
      environment.etc."specialisation".text = "gamingMode";
      lunix.profiles.gaming.enable = mkForce true;
    };
  };
}
