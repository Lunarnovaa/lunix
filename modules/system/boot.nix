{
  pkgs,
  config,
  ...
}: let
  inherit (config.lunix.theme.fonts) monospace;
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
      "1e1e2e" # base
      "f38ba8" # red
      "a6e3a1" # green
      "f9e2af" # yellow
      "89b4fa" # blue
      "f5c2e7" # pink
      "94e2d5" # teal
      "bac2de" # subtext 1

      "585b70" # surface 2
      "f38ba8" # red
      "a6e3a1" # green
      "f9e2af" # yellow
      "89b4fa" # blue
      "f5c2e7" # pink
      "94e2d5" # teal
      "a6adc8" # subtext 0
    ];
  };
}
