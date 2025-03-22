{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  # Referenced from NotAShelf/nyx, fetching css file directly as opposed to importing the import of this style sheet :)
  catppuccin-mocha-css = pkgs.fetchurl {
    url = "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css";
    sha256 = "1mpmzkpn13hbj880wbpr0iqhhazryav2rfvy8d5gbziv6h475sck";
  };

  cfg = config.profiles.gaming.programs.vesktop;
in {
  config = mkIf cfg.enable {
    hjem.users.lunarnova = {
      packages = [pkgs.vesktop];
      files = {
        ".config/vesktop/themes/catppuccin-mocha.css".source = catppuccin-mocha-css;
      };
    };
  };
}
