{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  imports = [inputs.spicetify-nix.nixosModules.default];
  config = mkIf config.loose.spicetify {
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in {
      enable = true;
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
  };
}
