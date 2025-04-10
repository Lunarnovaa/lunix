{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (builtins) concatLists;

  cfg = config.desktops.hyprland;
in {
  config = mkIf cfg.enable {
    programs.hyprland.settings = {
      windowrulev2 = [
        # Gaming
        "workspace 3, class:(steam)"
        "workspace 3, initialTitle:(Lutris)"
        "workspace 3, class:(org.prismlauncher.PrismLauncher)"

        # Comforts
        "workspace 2, class:(vesktop)"
        "workspace 2, initialTitle:(Spotify Premium)"

        # Productivity
        "workspace 1, class:(firefox)"
        "workspace 1, initialTitle:(Visual Studio Code)"
      ];

      workspace = concatLists [
        cfg.monitors.rules
        [
          # for smart gaps, reference https://wiki.hyprland.org/Configuring/Workspace-Rules/#smart-gaps
        ]
      ];
    };
  };
}
