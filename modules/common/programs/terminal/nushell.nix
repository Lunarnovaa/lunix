{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  novavimDir = "${config.hjem.users.lunarnova.directory}/projects/novavim";

  cfg = config.lunix.programs.nushell;
in {
  options = {
    lunix.programs.nushell = {
      enable = mkEnableOption "nushell";
      package = mkPackageOption pkgs "nushell" {};
    };
  };

  config = mkIf cfg.enable {
    users.users.lunarnova.shell = cfg.package;
    hjem.users.lunarnova.rum.programs.nushell = {
      enable = true;
      inherit (cfg) package;
      settings.show_banner = false;
      aliases.ll = "ls -l";
      plugins = with pkgs.nushellPlugins; [units formats];
      extraConfig = ''$env.config.buffer_editor = "vi"'';
      envFile = ''$env.config.color_config.shape_bool = "green"'';
    };
    /*
      hjem.users.lunarnova = {
      packages = [pkgs.nushell];
      files = {
        ".config/nushell/config.nu".text = ''

          # disabling the basic banner on startup
          $env.config.show_banner = false

          load-env {${nuVars}}

          # aliases and other stuff

          alias ll = ls -l
          alias ndev = nix develop --command nu

          alias spp = spotify_player

          alias devnovavim = nix run ${novavimDir} ${novavimDir}

          def nbuild [] {
              cd ~/nix-tools
              nix develop --command nu
          }

          def agsr [] {
            nix shell github:aylur/ags#agsFull -c ags run ~/nixconf/modules/desktop/hyprland/astal/src/app.ts --gtk4
          }

          def webdev [--run (-r)] {
            cd ~/aurabora.org
            if $run {
              nix develop --command pnpm run dev
            } else {
              nix develop --command nu
            }
          }


          # starship init

          use ${starshipCache}/init.nu
        '';
        ".config/nushell/env.nu".text = ''
          # defines the starship init process
          mkdir ${starshipCache}
          starship init nu | save -f ${starshipCache}/init.nu
        '';
      };
    };
    */
  };
}
