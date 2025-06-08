{
  config,
  inputs',
  lib,
  pkgs,
  theme,
  ...
}: let
  inherit (builtins) toJSON;
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.strings) optionalString;
  inherit (theme.colors) base00 base05 base02 base08 base0B base03;
  inherit (theme.fonts) monospace;

  waybar-config = pkgs.writeText "waybar-config.jsonc" (toJSON {
    position = "left";
    layer = "top";
    modules-left = [
      # top
      "niri/workspaces"
    ];
    modules-center = ["clock"];
    modules-right = [
      # bottom
      #"niri/language"
      (optionalString cfgPowersave.enable "battery")
      "wireplumber"
      "bluetooth"
      "network"
      "custom/power"
    ];

    # Module Configuration

    ## Top
    "niri/workspaces" = {
      format = "{icon}";
      format-icons = {
        browser = "󰈹";
        gaming = "󰓓";
      };
    };

    ## Center
    clock = {
      format = "{:%H\n%M}";
      tooltip = true;
      tooltip-format = "{:%D}";
      calendar = {
        mode = "month";
        /*
          format = {
          months = "";
        };
        */
      };
    };

    ## Bottom
    "niri/language" = {
      format = "{variant}";
    };
    battery = {
      format = "{icon}";
      format-icons = ["" "" "" "" ""];
      tooltip-format = "{capacity}%\n{time}";
    };
    wireplumber = {
      format = "{icon}";
      format-muted = "";
      format-icons = ["" "" ""];
      tooltip-format = "{volume}%";
    };
    bluetooth = {
      on-click = "${inputs'.bzmenu.packages.default}/bin/bzmenu -l walker";
      format-disabled = "󰂲"; # Controller is disabled
      format-on = "󰂯"; # On, no device connected
      format-off = "󰂲"; # Controller is turned off
      format-connected = "󰂱"; # Connected to device
      format-no-controller = ""; # No bluetooth support
      tooltip-format = "{status}";
      tooltip-format-connected = "{device_alias}";
      tooltip-format-connected-battery = "{device_alias}, {device_battery_percentage}%";
    };
    network = {
      on-click = "${inputs'.iwmenu.packages.default}/bin/iwmenu -l walker";
      format-ethernet = "󰈀";
      format-disconnected = "󰤮";
      format-wifi = "{icon}";
      format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
      tooltip-format-ethernet = "{ifname}";
      tooltip-format-wifi = "{essid} ({signalStrength}%)";
      tooltip-format-disconnected = "Disconnected";
    };
    "custom/power" = {
      format = "⏻";
      tooltip = false;
      on-click = "shutdown";
    };
  });

  waybar-style =
    pkgs.writeText "waybar-style.css"
    # css
    ''
      /* Barwide Settings */
      * {
        font-family: ${monospace.name};
        font-size: 14px;
        min-width: 20px;
        color: ${base05};
      }
      #waybar {
        background-color: shade(${base00},0.9);
        border: 4px solid alpha(${base02},0.3);
      }

      box.module {
      }
      label.module {
        background-color: ${base02}; /* surface0 */
        padding: 0.5rem;
      }

      button:hover {
        background-color: shade(${base00},0.7);
      }

      /* Top Modules */
      #workspaces {
        background-color: ${base02}; /* surface0 */
        border-radius: 0.5rem;
        margin: 5px;
      }
      #workspaces button {
        border-radius: 0.5rem;
        padding: 0.5rem;
      }
      #workspaces button.focused {
        border-radius: 0.5rem;
        background-color: ${base03}; /* surface1 */
      }

      #workspaces button:hover {
        border-radius: 0.5rem;
      }

      /* Center Module */
      #clock {
        margin: 5px;
        border-radius: 1rem;
      }

      /* Top of Systray */
      #wireplumber {
        margin: 2px 4px 0px;
        border-radius: 0.5rem 0.5rem 0rem 0rem;
      }

      /* Center Systray Modules */
      #niri-language,
      #battery,
      #bluetooth
      {
        margin: 0px 4px;
      }

      /* Bottom of Systray */
      #network {
        margin: 0px 4px 2px;
        border-radius: 0rem 0rem 0.5rem 0.5rem;
      }

      ${
        optionalString cfgPowersave.enable
        #css
        ''
          #battery.charging {
            color: ${base0B}; /* green */
          }

          #battery.warning:not(.charging) {
            color: ${base08}; /* red */
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: steps(12);
            animation-iteration-count: infinite;
            animation-direction: alternate;
          }
        ''
      }

      /* Power Module */
      #custom-power  {
        margin: 4px;
        border-radius: 0.5rem;
      }
    '';

  cfgPowersave = config.lunix.hardware.powersave;
  cfgNiri = config.lunix.desktops.niri;
  cfg = config.lunix.programs.waybar;
in {
  options = {
    lunix.programs.waybar = {
      enable =
        mkEnableOption "Waybar"
        // {
          default = cfgNiri.enable;
          defaultText = "config.lunix.desktops.niri.enable";
        };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.waybar = let
      target = ["graphical-session.target"];
    in {
      description = "Highly customizable bar for Wayland";
      wantedBy = ["niri.service"];
      partOf = target;
      after = target;
      requisite = target;
      serviceConfig = {
        ExecStart = "${pkgs.waybar}/bin/waybar -c ${waybar-config} -s ${waybar-style}";
        Restart = "on-failure";
      };
      restartTriggers = [waybar-config waybar-style pkgs.waybar];
    };
  };
}
