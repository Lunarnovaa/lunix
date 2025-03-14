{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) listOf package;
  inherit (lib.modules) mkIf;

  cfg = config.desktops.gnome;
in {
  options.desktops.gnome = {
    enable = mkEnableOption "GNOME Desktop Environment";
    extensions = {
      enable = mkEnableOption "GNOME Extensions";
      packages = mkOption {
        type = listOf package;
        default = [];
        example = with pkgs.gnomeExtensions; [
          blur-my-shell
          pop-shell
        ];
      };
    };
  };

  config.desktops.gnome = mkIf cfg.enable {
    extensions.enable = true; # Extensions are enabled by default
  };
}
