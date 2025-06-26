{inputs, ...}: {
  # withSystem makes 'pkgs' available so that different systems have the respective package set
  perSystem = {
    pkgs,
    lunixpkgs,
    ...
  }: {
    _module.args.theme = {
      colors = inputs.basix.schemeData.base24.catppuccin-mocha.palette;
      fonts = {
        # packaged by yours truly
        monospace = let
          type = "Mono";
          nerd = true;
          package = lunixpkgs.ioshelfka.override {inherit type nerd;};
        in {
          inherit package;
          name = "Ioshelfka Mono Nerdfont";
          file = "${package}/share/fonts/truetype/Ioshelfka" + type + "-Regular.ttf";
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
