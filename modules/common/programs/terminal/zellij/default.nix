{pkgs, ...}: {
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
    packages = [pkgs.zellij];
    xdg.config.files."zellij/config.kdl".source = pkgs.concatText "zellij-config" [
      ./config.kdl
      ./keybinds.kdl
    ];
  };
}
