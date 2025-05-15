{
  config,
  lib,
  theme,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (theme) wallpapers fonts colors;
  inherit (inputs.lunarsLib.generators) toSwaylockConf;

  cfg = config.desktops.hyprland;
in {
  config = mkIf cfg.enable {
    # config and pam module both referenced in part from notashelf/nyx
    hjem.users.lunarnova.files.".config/swaylock/config".text = toSwaylockConf {
      attrs = {
        font = fonts.sans.name;
        font-size = 18;

        image = "${wallpapers.primary}";
        effect-blur = "7x6";

        clock = true;
        indicator = true;
        timestr = "%H:%M";
        datestr = "%m.%d.%y";

        line-color = "${colors.base01}";
        text-color = "${colors.base05}";
        ring-color = "${colors.base00}";
        key-hl-color = "${colors.base08}";

        ring-ver-color = "${colors.base17}";
        inside-ver-color = "${colors.base0E}";

        ring-clear-color = "${colors.base14}";
        inside-clear-color = "${colors.base0B}";

        ring-wrong-color = "${colors.base10}";
        inside-wrong-color = "${colors.base12}";
      };
    };
    security.pam.services = {
      swaylock = {
        name = "swaylock";
        text = ''
          auth  include login
        '';
      };
    };
  };
}
