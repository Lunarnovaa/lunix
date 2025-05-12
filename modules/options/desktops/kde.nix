{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.desktops.kde = {
    enable = mkEnableOption "KDE Plasma 6";
  };
}
