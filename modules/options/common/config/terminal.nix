{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;

  cfg = config.terminal;
in {
  options.terminal = {
    enable = mkEnableOption "terminal modules" // {default = true;};
    apps = {
      alacritty.enable = mkEnableOption "alacritty terminal" // {default = false;};
      fish.enable = mkEnableOption "fish shell" // {default = cfg.enable;};
      foot.enable = mkEnableOption "foot terminal" // {default = cfg.enable;};
      nushell.enable = mkEnableOption "nushell" // {default = false;};
      starship.enable = mkEnableOption "starship" // {default = cfg.enable;};
    };
  };
}
