{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkDefault mkIf;
in {
  options.terminal = {
    enable = mkEnableOption ''
      Enables the terminal modules, installing and configuring
      the terminal emulator, shell, and prompt.
    '';
    apps = {
      alacritty = mkEnableOption ''
        the Alacritty terminal.
      '';
      foot.enable = mkEnableOption "foot terminal";
      nushell = mkEnableOption ''
        nushell & its aliases.
      '';
      spaceship = mkEnableOption ''
        the spaceship prompt.
      '';
    };
  };
  config = {
    terminal.enable = mkDefault true;

    terminal.apps = mkIf config.terminal.enable {
      #alacritty = mkDefault false;
      foot.enable = mkDefault true;
      nushell = mkDefault true;
      spaceship = mkDefault true;
    };
  };
}
