{pkgs, ...}: {
  lunix.programs.terminal.aliases.zj = "zellij";
  hjem.users.lunarnova = {
    packages = [pkgs.zellij];
    files.".config/zellij/config.kdl".source = pkgs.concatText "zellij-config" [
      ./config.kdl
      ./keybinds.kdl
    ];
  };
}
