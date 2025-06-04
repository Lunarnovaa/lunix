{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  gamemode = pkgs.pkgs.writeShellScriptBin "enable-gamemode" ''
    HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
    if [ "$HYPRGAMEMODE" = 1 ] ; then
        hyprctl --batch "\
            keyword animations:enabled 0;\
            keyword decoration:drop_shadow 0;\
            keyword decoration:blur:enabled 0;\
            keyword general:gaps_in 0;\
            keyword general:gaps_out 0;\
            keyword general:border_size 1;\
            keyword decoration:rounding 0"
        exit
    fi
    hyprctl reload
  '';

  cfgGaming = config.lunix.profiles.gaming;
  cfg = config.lunix.desktops.hyprland;
in {
  config = mkIf (cfg.enable && cfgGaming.enable) {
    programs.hyprland.settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, F1, exec, ${gamemode}/bin/enable-gamemode"

        # Game mode settings

        ## Unbinding the homerow arrow keys for The Core RTS keybinds
        "$mod, B, exec, hyprctl keyword unbind CONTROL, n"
        "$mod, B, exec, hyprctl keyword unbind CONTROL, e"
        "$mod, B, exec, hyprctl keyword unbind CONTROL, i"
        "$mod, B, exec, hyprctl keyword unbind CONTROL, u"

        ## Rebinding homerow arrow keys
        "$mod, K, exec, hyprctl keyword bind CONTROL, n, sendshortcut,, Left, activewindow"
        "$mod, K, exec, hyprctl keyword bind CONTROL, e, sendshortcut,, Down, activewindow"
        "$mod, K, exec, hyprctl keyword bind CONTROL, i, sendshortcut,, Right, activewindow"
        "$mod, K, exec, hyprctl keyword bind CONTROL, u, sendshortcut,, Up, activewindow"
      ];
    };
  };
}
