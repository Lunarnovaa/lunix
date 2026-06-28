{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.filesystem) listFilesRecursive;
in {
  environment.shellAliases = {
    zj = "zellij";
    lunix = "cd ~/Projects/lunix && zellij";
  };
  hjem.users.lunarnova = {
    packages = [pkgs.zellij];
    xdg.config.files = {
      "zellij/config.kdl".source = pkgs.concatText "zellij-config" (listFilesRecursive ./config);
    };
  };
}
