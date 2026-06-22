{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) attrsOf str submodule package;
in {
  options.lunix.theme = {
    fonts = mkOption {
      type = attrsOf (submodule {
        options = {
          package = mkOption {
            type = package;
            default = null;
          };
          name = mkOption {
            type = str;
            default = "";
            example = "Fira Code";
          };
          file = mkOption {
            type = str;
            default = "";
          };
        };
      });

      default = {
        monospace = let
          package = pkgs.fira-code;
        in {
          inherit package;
          name = "Fira Code";
          file = "${package}/share/fonts/truetype/FiraCode-VF.ttf";
        };
        sans = {
          package = pkgs.inter;
          name = "Inter";
        };
        serif = {
          package = pkgs.roboto-serif;
          name = "Roboto Serif";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        cjk-sans = {
          package = pkgs.noto-fonts-cjk-sans;
          name = "Noto Sans CJK SC";
        };
        cjk-serif = {
          package = pkgs.noto-fonts-cjk-serif;
          name = "Noto Serif CJK SC";
        };
      };
    };
  };
}
