{
  inputs,
  lib,
  ...
}: let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.strings) removePrefix;

  base24 = inputs.basix.schemeData.base24.catppuccin-mocha.palette;
in {
  # withSystem makes 'pkgs' available so that different systems have the respective package set
  perSystem = {
    pkgs,
    lunixpkgs,
    ...
  }: let
    monospace = {
      type = "Mono";
      nerd = true;
      package = lunixpkgs.ioshelfka.override {inherit (monospace) type nerd;};
    };
  in {
    _module.args.theme = {
      colors = base24;
      colorsNoHash = mapAttrs (_: v: removePrefix "#" v) base24;
      fonts = {
        # packaged by yours truly
        monospace = {
          inherit (monospace) package;
          name = "Ioshelfka Mono Nerdfont";
          file = "${monospace.package}/share/fonts/truetype/Ioshelfka" + monospace.type + "-Regular.ttf";
        };
        sans = {
          package = pkgs.inter;
          name = "Inter";
          path = "${pkgs.inter}/share/fonts/truetype/Inter.ttc";
        };
        serif = {
          package = pkgs.roboto-serif;
          name = "Roboto Serif";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        cjk = {
          sans = {
            package = pkgs.noto-fonts-cjk-sans;
            name = "Noto Sans CJK SC";
          };
          serif = {
            package = pkgs.noto-fonts-cjk-serif;
            name = "Noto Serif CJK SC";
          };
        };
        size = 11;
      };
      wallpapers = {
        primary = ../../catppuccin-hollow-knight.jpg;
      };
    };
  };
}
