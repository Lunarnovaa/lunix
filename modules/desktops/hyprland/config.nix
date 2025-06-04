{
  config,
  pkgs,
  lib,
  theme,
  self',
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.strings) removePrefix;
  inherit (theme) colors;
  inherit (builtins) mapAttrs;

  # cleansing the imported colors from basix of the prepended '#'
  # bc colors don't work here without it
  # optimized by notashelf
  hyprCol = mapAttrs (_: v: removePrefix "#" v) colors;

  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    ${pkgs.mako}/bin/mako &
    systemctl --user start ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &
    ${self'.packages.lags}/bin/lags &
    ${pkgs.sway-audio-idle-inhibit}/bin/sway-audio-idle-inhibit &
  '';

  cfg = config.lunix.desktops.hyprland;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova.packages = [inputs.niqspkgs.legacyPackages.${pkgs.system}.bibata-hyprcursor];

    programs.hyprland.settings = {
      exec-once = ''${startupScript}/bin/start'';

      monitor = cfg.monitors.configuration;

      input = {
        # Set Colemak as the primary layout and QWERTY as secondary
        kb_layout = "us,us";
        kb_variant = "colemak,";

        # Remap CAPSLOCK to CTRL, WIN+SPACE kb layout change
        kb_options = "ctrl:nocaps,grp:win_space_toggle";
        accel_profile = "flat";

        sensitivity = "-0.2";
      };

      misc = {
        middle_click_paste = false;
      };

      env = [
        "ELECTRON_OZONE_PLATFORM_HINT,auto"

        "HYPRCURSOR_THEME,Bibata-modern"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        border_size = "3";
        gaps_out = "10,10,10,10";
        gaps_in = "4";

        "col.inactive_border" = "0x00${hyprCol.base03}";
        "col.active_border" = "0xee${hyprCol.base04} 0xee${hyprCol.base06} 45deg"; #Gradient from surface2 to red
      };

      decoration = {
        rounding = "5";

        shadow = {
          #range = 6;
          render_power = 1;
        };

        active_opacity = 0.95;
        inactive_opacity = 0.95;

        blur = {
        };
      };
    };
  };
}
