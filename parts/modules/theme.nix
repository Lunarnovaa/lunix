{lib, ...}: let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.strings) removePrefix;
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
