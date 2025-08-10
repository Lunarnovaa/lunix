{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.meta) getExe;
in {
  hjem.users.lunarnova.rum.desktops.niri.binds = {
    "Mod+1".action = "focus-workspace \"browser\"";
    "Mod+Shift+1".action = "move-column-to-workspace \"browser\"";
    "Mod+2".action = "focus-workspace \"gaming\"";
    "Mod+Shift+2".action = "move-column-to-workspace \"gaming\"";
    "Mod+3".action = "focus-workspace 3";
    "Mod+Shift+3".action = "move-column-to-workspace 3";

    "Mod+N".action = "focus-column-left";
    "Mod+E".action = "focus-window-or-workspace-down";
    "Mod+U".action = "focus-window-or-workspace-up";
    "Mod+I".action = "focus-column-right";

    "Mod+F".action = "maximize-column";
    "Mod+F11".action = "fullscreen-window";
    "Mod+c".action = "center-column";

    "Mod+Minus".action = "set-column-width \"-10%\"";
    "Mod+Plus".action = "set-column-width \"+10%\"";

    "Mod+V".action = "toggle-window-floating";
    "Mod+Shift+V".action = "switch-focus-between-floating-and-tiling";

    "Mod+Slash".spawn = ["walker"];

    "Mod+Return".spawn = ["foot"];
    "Mod+G".spawn = ["firefox"];

    "Mod+D".action = "close-window";

    Print.action = "screenshot";
    "Shift+Print".action = "screenshot-screen";
    "Ctrl+Print".action = "screenshot-window";

    "Mod+Shift+Escape".spawn = ["swaylock"];
    "Mod+Escape" = {
      parameters.repeat = false;
      action = "toggle-overview";
    };
    XF86AudioRaiseVolume = {
      parameters.allow-when-locked = true;
      spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
    };
    XF86AudioLowerVolume = {
      parameters.allow-when-locked = true;
      spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
    };
    XF86AudioMute = {
      parameters.allow-when-locked = true;
      spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
    };
    XF86MonBrightnessUp = {
      parameters.allow-when-locked = true;
      spawn = ["${getExe pkgs.brightnessctl}" "set" "5%+"];
    };
    XF86MonBrightnessDown = {
      parameters.allow-when-locked = true;
      spawn = ["${getExe pkgs.brightnessctl}" "set" "5%-"];
    };
  };
}
