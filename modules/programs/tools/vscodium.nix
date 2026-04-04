{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    defaultEditor = true;
  };
}
