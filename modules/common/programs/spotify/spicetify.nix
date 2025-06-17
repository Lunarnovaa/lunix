{
  lib,
  pkgs,
  config,
  pins,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  spicetify-nix = import pins.spicetify-nix {inherit pkgs;};

  spicePkgs = spicetify-nix.packages;

  spicetify = spicetify-nix.lib.mkSpicetify pkgs {
    enabledExtensions = with spicePkgs.extensions; [
      powerBar
      fullAlbumDate
      fullAppDisplay
      listPlaylistsWithSong
      playNext
      volumePercentage
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      newReleases
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };

  cfg = config.lunix.programs.spicetify;
in {
  options = {
    lunix.programs.spicetify = {
      enable = mkEnableOption "spicetify";
    };
  };

  config = mkIf cfg.enable {
    hjem.users.lunarnova.packages = [spicetify];
  };
}
