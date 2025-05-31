{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  toTOML = (pkgs.formats.toml {}).generate;

  cfg = config.terminal.apps.starship;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = [pkgs.starship];
      files.".config/starship.toml".source = toTOML "starship config" {
        add_newline = false;
      };
    };
  };
}
