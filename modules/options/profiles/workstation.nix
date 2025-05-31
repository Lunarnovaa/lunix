{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;

  cfg = config.profiles.workstation;
in {
  options.profiles.workstation = {
    enable = mkEnableOption "Workstation modules";
    programs = {
      obsidian.enable = mkEnableOption "Obsidian Markdown Editor" // {default = false;};
      libreoffice.enable = mkEnableOption "Libreoffice Suite" // {default = cfg.enable;};
      vscode.enable = mkEnableOption "Visual Studio Code" // {default = false;};
      zed.enable = mkEnableOption "Zed Editor" // {default = false;};
    };
  };
}
