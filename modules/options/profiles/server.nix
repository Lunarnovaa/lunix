{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;

  cfg = config.profiles.server;
in {
  options.profiles.server = {
    enable = mkEnableOption ''
      the server modules. Currently this doesn't do much
      since I haven't delved into server stuff quite yet.
    '';
    services = {
      minecraft.enable = mkEnableOption "the Minecraft server" // {default = cfg.enable;};
    };
  };
}
