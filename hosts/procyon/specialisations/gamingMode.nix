{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  # Specialisation for "Gaming Mode": Enables Gaming Module
  specialisation.gamingMode.configuration = {
    environment.etc."specialisation".text = "gamingMode";
    profiles.gaming.enable = mkForce true;
  };
}
