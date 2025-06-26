{
  pkgs,
  theme,
  ...
}: let
  inherit (theme.fonts) monospace;
in {
  boot.plymouth = {
    enable = true;
    themePackages = [pkgs.plymouth-blahaj-theme];
    theme = "blahaj";
    font = monospace.file;
  };
}
