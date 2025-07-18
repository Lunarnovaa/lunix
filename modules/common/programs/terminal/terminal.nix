{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) attrsOf str;
in {
  options = {
    lunix.terminal = {
      aliases = mkOption {
        type = attrsOf str;
        default = {};
        description = "Aliases to be added to your user shell.";
      };
    };
  };
  config.lunix.terminal.aliases = {
    ll = "${pkgs.eza}/bin/eza -l";
    lt = "${pkgs.eza}/bin/eza --tree";
    ndev = "nix develop";
    nrun = "nix run";
    spp = "spotify_player";
  };
}
