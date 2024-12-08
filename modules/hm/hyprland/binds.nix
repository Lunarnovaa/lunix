{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (lib)
    mkIf
    mkMerge
    ;
  inherit
    (config.hyprland)
    monitors
    ;
  killactive = pkgs.pkgs.writeShellScriptBin "save-steam" ''
    if [ "$(hyprctl activewindow -j | jq -r ".class")" = "Steam" ]; then
        xdotool getactivewindow windowunmap
    else
        hyprctl dispatch killactive ""
    fi
  '';
in {
  config = mkIf config.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";

      bind = mkMerge [
        monitors.bind
        [
          "$mod, G, exec, firefox"
          "$mod, Return, exec, alacritty"
          "$mod, M, exec, vesktop --disable-gpu-compositing"

          "$mod, D, exec, ${killactive}/bin/save-steam"

          ", Print, exec, ${pkgs.grimblast}/bin/grimblast --notify --freeze copy area"
          "ALT, Tab, cyclenext,"
          "ALT, Tab, bringactivetotop,"

          "ALT, 1, workspace, 1"
          "ALT, 2, workspace, 2"
          "ALT, 3, workspace, 3"
          "ALT, 4, workspace, 4"
          "$mod, 1, movetoworkspace, 1"
          "$mod, 2, movetoworkspace, 2"
          "$mod, 3, movetoworkspace, 3"
          "$mod, 4, movetoworkspace, 4"

          "$mod, BackSpace, togglefloating, active"

          # Creates arrow keys on homerow :)
          "Control_L, n, sendshortcut,, Left, activewindow"
          "Control_L, e, sendshortcut,, Down, activewindow"
          "Control_L, i, sendshortcut,, Right, activewindow"
          "Control_L, u, sendshortcut,, Up, activewindow"
        ]
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindr = [
        "SUPER, SUPER_L, exec, tofi-drun --drun-launch=true"
      ];
      bindel = [
        # support for media keys
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
      ];
      bindl = [
        # more support for media keys
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"

        # opening and closing of the lid
        ", switch:off:Lid Switch, exec, systemctl suspend"
      ];
    };
  };
}
