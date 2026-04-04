{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  # Load into steam-session
  specialisation = {
    steam-session.configuration = {
      environment.etc.specialisation.text = "steam-session";
      lunix = {
        desktops = {
          steam-session.enable = true;
        };
        profiles.gaming.enable = mkForce true;
      };
    };
  };
}
