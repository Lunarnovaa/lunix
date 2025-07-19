{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkDefault;
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;

  cfg = config.lunix.programs.terminal;
in {
  options = {
    lunix.programs.terminal = {
      emulator = mkOption {
        type = enum ["foot"]; # Currently only foot is available
        default = "foot";
        description = "The terminal emulator to use.";
      };
    };
  };
  config = {
    lunix.programs.foot = {
      enable = mkDefault (cfg.emulator == "foot");
    };
  };
}
