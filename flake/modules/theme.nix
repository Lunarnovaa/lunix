{inputs, ...}: {
  # withSystem makes self' available so that different systems have the respective package set
  perSystem = {pkgs, ...}: {
    _module.args.theme = {
      colors = inputs.basix.schemeData.base24.catppuccin-mocha.palette;
      fonts = {
        monospace = {
          package = pkgs.ioshelfka; # packaged by yours truly
          name = "Ioshelfka Mono Nerdfont";
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
        primary = "/home/lunarnova/wallpapers/nauragarden.png";
      };
    };
  };
}
