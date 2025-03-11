{lib,...}: let 
  inherit (lib.options) mkEnableOption;

in {
  options.gnome = {
    enable = mkEnableOption "GNOME Desktop Environment";
  };
}