{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;

  yazi-flavors = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "flavors";
    rev = "d3fd3a5d774b48b3f88845f4f0ae1b82f106d331";
    hash = "sha256-RtunaCs1RUfzjefFLFu5qLRASbyk5RUILWTdavThRkc=";
  };

  cfg = config.lunix.programs.yazi;
in {
  options = {
    lunix.programs.yazi = {
      enable = mkEnableOption "Yazi" // {default = true;};
    };
  };
  config = mkIf cfg.enable {
    lunix.programs.terminal.aliases.y = "yazi";
    programs.yazi = {
      enable = true;
      flavors.catppuccin-mocha = "${yazi-flavors}/catppuccin-mocha.yazi";
      plugins = {
        inherit (pkgs.yaziPlugins) yatline rich-preview smart-enter lazygit;
      };
      settings = {
        theme.flavor.dark = "catppuccin-mocha";
        #yazi = {};
        keymap = {
          mgr.prepend-keymap = [
            {
              on = "l";
              run = "plugin-smart-enter";
              desc = "Enter the child directory, or open the file";
            }
            {
              on = ["g" "i"];
              run = "plugin lazygit";
              desc = "run lazygit";
            }
          ];
        };
      };
    };
  };
}
