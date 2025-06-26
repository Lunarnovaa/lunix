{
  theme,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.strings) removePrefix;
  inherit (theme.fonts) monospace;
  inherit (colors) base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base10 base11 base12 base13 base14 base15;

  colors = mapAttrs (_: v: removePrefix "#" v) theme.colors;
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
      base00
      base01
      base02
      base03
      base04
      base05
      base06
      base07
      base08
      base09
      base10
      base11
      base12
      base13
      base14
      base15
    ];
  };
}
