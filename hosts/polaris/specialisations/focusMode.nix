{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  # "Focus Mode": Disables Gaming Modules
  specialisation.focusMode.configuration = {
    environment.etc."specialisation".text = "focusMode";
    profiles.gaming.enable = mkForce false;
  };
}
