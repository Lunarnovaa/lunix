{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  toTOML = (pkgs.formats.toml {}).generate;
in {
  config = mkIf config.terminal.apps.spaceship {
    hjem.users.lunarnova = {
      packages = [pkgs.starship];
      files.".config/starship.toml".source = toTOML "starship config" {
        add_newline = false;
      };
    };
  };
}
