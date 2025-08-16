{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.filesystem) listFilesRecursive;
in {
  lunix.programs.terminal.aliases.zj = "zellij";
  hjem.users.lunarnova = {
    packages = [pkgs.zellij];
    xdg.config.files = {
      "zellij/config.kdl".source = pkgs.concatText "zellij-config" (listFilesRecursive ./config);
    };
  };
}
