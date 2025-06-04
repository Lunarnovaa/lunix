{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.lunix.programs.fish;
in {
  options = {
    lunix.programs.fish = {
      enable = mkEnableOption "Fish" // {default = true;};
      package = mkPackageOption pkgs "fish" {};
    };
  };

  config = mkIf cfg.enable {
    users.users.lunarnova.shell = cfg.package;
    programs.fish = {
      enable = true;
      inherit (cfg) package;
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
      inherit (cfg) package;
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
