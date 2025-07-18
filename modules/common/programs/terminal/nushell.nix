{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.programs.nushell;
in {
  options = {
    lunix.programs.nushell = {
      enable = mkEnableOption "nushell" // {default = true;};
    };
  };

  config = mkIf cfg.enable {
    users.users.lunarnova.shell = pkgs.nushell;
    hjem.users.lunarnova.rum.programs.nushell = {
      enable = true;
      inherit (config.lunix.terminal) aliases;
      settings.show_banner = false;
      extraConfig =
        # nu
        ''
          def webdev [--run (-r)] {
            cd ~/aurabora.org
            if $run {
              nix develop --command pnpm run dev
            } else {
              nix develop --command nu
            }
          }
        '';
    };
  };
}
