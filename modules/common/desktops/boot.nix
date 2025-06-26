{
  theme,
  pkgs,
  ...
}: let
  inherit (theme.fonts) monospace;
  inherit (theme.colorsNoHash) base00 base04 base08 base0A base0B base0C base0D base17;
in {
  boot = {
    plymouth = {
      enable = true;
      themePackages = [pkgs.plymouth-blahaj-theme];
      theme = "blahaj";
      font = monospace.file;
    };
    kernelParams = ["quiet"];
  };
  console = {
    colors = [
      base00 # base
      base08 # red
      base0B # green
      base0A # yellow
      base0D # blue
      base17 # pink
      base0C # teal
      "bac2de" # subtext 1

      base04 # surface 2
      base08 # red
      base0B # green
      base0A # yellow
      base0D # blue
      base17 # pink
      base0C # teal
      "a6adc8" # subtext 0
    ];
  };
}
