{...}: let
  primaryDisplay = "eDP-1";
in {
  desktops.hyprland = {
    enable = true;
    monitors = {
      configuration = [
        "${primaryDisplay}, preferred, auto, 1.333333"
      ];
      #bind = [];
      #rules = [];
    };
  };
}
