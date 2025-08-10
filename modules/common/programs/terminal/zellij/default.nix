{
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (inputs.lunarsLib.builders) wrapPackage;
  inherit (lib.filesystem) listFilesRecursive;

  zellij-config = pkgs.concatText "zellij-config.kdl" (listFilesRecursive ./config);
in {
  lunix.programs.terminal.aliases = {
    zj = "zellij";
    edit =
      "zellij --layout "
      + pkgs.writeText "standard-layout.kdl" ''
        layout {
          pane command="hx"
        }
      '';
  };
  hjem.users.lunarnova = {
    packages = [
      (wrapPackage pkgs.zellij {
        args = ["--config" zellij-config];
      })
    ];
  };
}
