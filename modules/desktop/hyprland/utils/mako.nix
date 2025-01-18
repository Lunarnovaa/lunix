{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.theme) colors fonts;
  #hyprland-settings = config.wayland.windowManager.hyprland.settings;
in {
  config = mkIf config.hyprland.enable {
    hjem.users.lunarnova.files.".config/mako/config".text = ''
      max-visible=5
      sort=-time

      layer=overlay
      anchor=top-center

      font=${fonts.sans-serif}
      background-color=${colors.base01}
      text-color=${colors.base05}
      width=300
      height=80
      margin=10
      padding=5
      border-size=2
      border-color=${colors.base08}
      border-radius=3
      progress-color=#5588aa
      icons=true
      max-icon-size=64

      markup=true
      actions=true
      format=<b>%s</b>\n%b
      default-timeout=10000
      ignore-timeout=false
    '';
  };
}
