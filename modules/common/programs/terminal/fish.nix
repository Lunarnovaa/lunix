{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.terminal.apps.fish;
in {
  config = mkIf cfg.enable {
    users.users.lunarnova.shell = pkgs.fish;
    programs.fish = {
      enable = true;
      /*
        promptInit = "starship init fish | source";
      shellAbbrs = {
        ll = "${pkgs.eza}/bin/eza -l";
        ndev = "nix develop";
        nrun = "nix run";
        spp = "spotify_player";
        nvdev = let
          novavimDir = "${config.hjem.users.lunarnova.directory}/projects/novavim";
        in "nix run ${novavimDir} ${novavimDir}";
      };
      */
    };

    hjem.users.lunarnova.rum.programs.fish = {
      enable = true;
      config = ''
        starship init fish | source
      '';
      abbrs = {
        ll = "${pkgs.eza}/bin/eza -l";
        ndev = "nix develop";
        nrun = "nix run";
        spp = "spotify_player";
        nvdev = let
          novavimDir = "${config.hjem.users.lunarnova.directory}/projects/novavim";
        in "nix run ${novavimDir} ${novavimDir}";
      };
    };
  };
}
