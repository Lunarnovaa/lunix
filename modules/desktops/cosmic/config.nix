{
  config,
  lib,
  theme,
  lunarsLib,
  ...
}: let
  inherit (builtins) toString;
  inherit (lib.modules) mkIf;
  inherit (lunarsLib.generators.ron) mkRON;

  primaryWallpaper = toString theme.wallpapers.primary;

  cfg = config.lunix.desktops.cosmic;
in {
  config = mkIf cfg.enable {
    lunix.desktops.cosmic.settings = {
      CosmicBackground = {
        all = {
          output = "all";
          rotation_frequency = 300;
          filter_method = mkRON "enum" "Lanczos";
          scaling_mode = mkRON "enum" "Zoom";
          sampling_method = mkRON "enum" "Alphanumeric";
          source = mkRON "enum" {
            value = [primaryWallpaper];
            variant = "Path";
          };
          filter_by_theme = true;
        };
        same-on-all = true;
      };
      "CosmicSettings.Wallpaper".custom-images = [primaryWallpaper];

      CosmicSettings.active-page = "mouse";

      CosmicIdle.suspend_on_ac_time = mkRON "enum" "None";

      CosmicPanel.entries = ["Panel"];

      "CosmicPanel.Panel" = {
        anchor = mkRON "enum" "Left";
        anchor_gap = false;
        autohide = mkRON "enum" "None";
        exclusive_zone = true;
        expand_to_edges = true;
        opacity = 1.0;
        size = mkRON "enum" "XS";

        plugins_center = mkRON "optional" [
          "com.system76.CosmicAppletTime"
        ];

        plugins_wings = mkRON "optional" (mkRON "tuple" [
          # Top / Right
          [
            "com.system76.CosmicAppletWorkspaces"
          ]
          # Bottom / Left
          [
            "com.system76.CosmicAppletInputSources"
            "com.system76.CosmicAppletStatusArea"
            "com.system76.CosmicAppletTiling"
            "com.system76.CosmicAppletAudio"
            "com.system76.CosmicAppletNetwork"
            "com.system76.CosmicAppletBattery"
            "com.system76.CosmicAppletNotifications"
            "com.system76.CosmicAppletBluetooth"
            "com.system76.CosmicAppletPower"
          ]
        ]);
      };

      CosmicAppletTime = {
        first_day_of_week = 0; # Monday
        military_time = true; # 24hr time
        show_date_in_top_panel = true;
        show_seconds = false;
      };

      CosmicAppletAudio.show_media_controls_in_top_panel = false;

      CosmicTk = {
        interface_font = {
          family = theme.fonts.sans.name;
          weight = mkRON "enum" "Normal";
        };
        monospace_font = {
          family = theme.fonts.monospace.name;
          weight = mkRON "enum" "Normal";
        };
        show_maximize = false;
        show_minimize = false;
      };

      CosmicPortal.screenshot = {
        save_location = mkRON "enum" "Clipboard";
        choice = mkRON "enum" "Rectangle";
      };

      CosmicComp = {
        active_hint = true;
        autotile = true;
        autotile-behavior = mkRON "enum" "PerWorkspace";
        focus_follows_cursor = true;
        focus_follows_cursor_delay = 50; # ms
        /*
          input_default = {
          state = mkRON "enum" "Enabled";
          acceleration = mkRON "optional" {
            profile = mkRON "optional" (mkRON "enum" "Flat");
            speed = mkRON "raw" "-.52.6";
          };
        };

        xkb_config = {
          rules = "";
          model = "pc104";
          layout = "us,us";
          variant = "colemak,";
          options = mkRON "optional" ",caps:super";
          repeat-delay = 600;
          repeat_rate = 25;
        };
        */
      };
    };
  };
}
