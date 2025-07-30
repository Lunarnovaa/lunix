{
  config,
  pkgs,
  ...
}: let
  catppuccin-spotify-player = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "spotify-player";
    rev = "34b3d23806770185b72466d777853c73454b85a6";
    hash = "sha256-eenf1jB8b2s2qeG7wAApGwkjJZWVNzQj/wEZMUgnn5U=";
  };
in {
  lunix.programs.terminal.aliases.spp = "spotify_player";
  hjem.users.lunarnova = {
    rum.programs.spotify-player = {
      enable = true;
      settings = {
        client_id_command = "cat ${config.age.secrets.spotifyClientID.path}";
        theme = "Catppuccin-mocha";
        device = {
          name = "${config.networking.hostName}";
          device_type = "computer";
          volume = 60;
          normalization = true;
        };
      };
    };
    xdg.config.files."spotify-player/theme.toml".source = "${catppuccin-spotify-player}/theme.toml";
  };
}
