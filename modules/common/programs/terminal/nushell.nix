{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  starshipCache = "${config.hjem.users.lunarnova.directory}/.cache/starship";
in {
  config = mkIf config.terminal.apps.nushell {
    users.users.lunarnova.shell = pkgs.nushell;
    hjem.users.lunarnova = {
      packages = [pkgs.nushell];
      files = {
        ".config/nushell/config.nu".text = ''

          # disabling the basic banner on startup
          $env.config = {
            show_banner: false,
          }


          # aliases and other stuff

          alias ll = ls -l
          alias ndev = nix develop --command nu

          alias spp = spotify_player

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
  };
}
