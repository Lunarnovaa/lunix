{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkDefault mkIf;

  cfg = config.profiles.workstation;
in {
  options.profiles.workstation = {
    enable = mkEnableOption ''
      the workstation modules. This mainly installs and
      configures noteable programs like neovim and obsidian for
      writing and programming.
    '';
    programs = {
      obsidian.enable = mkEnableOption ''
        Obsidian Markdown Editor.
      '';
      libreoffice.enable = mkEnableOption ''
      Libre Office Suite.
      '';
      vscode.enable = mkEnableOption ''
        VSCode, a code editor.
      '';
      zed.enable = mkEnableOption ''
        Zed, a code editor.
      ''; # Zed is currently disabled by default.
    };
  };
  config = mkIf cfg.enable {
    profiles.workstation.programs = {
      obsidian.enable = mkDefault true;
      libreoffice.enable = mkDefault true;
      vscode.enable = mkDefault true;
    };
  };
}
