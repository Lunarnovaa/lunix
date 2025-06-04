{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  # "Focus Mode": Disables Gaming Modules
  config.specialisation = {
    focusMode.configuration = {
      environment.etc."specialisation".text = "focusMode";
      lunix.profiles.gaming.enable = mkForce false;
    };
  };
}
