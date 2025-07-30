{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkDefault;
  inherit (lib.options) mkOption;
  inherit (lib.types) enum attrsOf str;

  cfg = config.lunix.programs.terminal;
in {
  options = {
    lunix.programs.terminal = {
      shell = mkOption {
        type = enum ["nushell"];
        default = "nushell";
        description = "The shell to use.";
      };
      aliases = mkOption {
        type = attrsOf str;
        default = {};
        description = "Aliases to be added to your user shell.";
      };
    };
  };
  config = {
    lunix.programs = {
      nushell.enable = mkDefault (cfg.shell == "nushell");
      terminal.aliases = {
        ndev = "nix develop";
        nrun = "nix run";
      };
    };
  };
}
