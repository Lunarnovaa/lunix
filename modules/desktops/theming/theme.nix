{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.options) mkOption;
  inherit (lib.types) attrsOf str submodule package;
  inherit (lib.strings) removePrefix;

  # taken from notashelf/basix
  # just got tired of that useless input and their flakeless support sucks
  base24 = {
    base00 = "#1e1e2e";
    base01 = "#181825";
    base02 = "#313244";
    base03 = "#45475a";
    base04 = "#585b70";
    base05 = "#cdd6f4";
    base06 = "#f5e0dc";
    base07 = "#b4befe";
    base08 = "#f38ba8";
    base09 = "#fab387";
    base0A = "#f9e2af";
    base0B = "#a6e3a1";
    base0C = "#94e2d5";
    base0D = "#89b4fa";
    base0E = "#cba6f7";
    base0F = "#f2cdcd";
    base10 = "#181825";
    base11 = "#11111b";
    base12 = "#eba0ac";
    base13 = "#f5e0dc";
    base14 = "#a6e3a1";
    base15 = "#89dceb";
    base16 = "#74c7ec";
    base17 = "#f5c2e7";
  };
in {
  options.lunix.theme = {
    colors = mkOption {
      type = attrsOf str;
      default = base24;
    };
    colorsNoHash = mkOption {
      type = attrsOf str;
      default = mapAttrs (_: v: removePrefix "#" v) base24;
    };
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
