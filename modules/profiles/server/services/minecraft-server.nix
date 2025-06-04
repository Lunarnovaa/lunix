{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.lunix.services.minecraft-server;
in {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];

  options = {
    lunix.services.minecraft-server = {
      enable = mkEnableOption "Minecraft Server";
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [inputs.nix-minecraft.overlay];

    services.minecraft-servers = {
      enable = true;
      eula = true;

      servers = {
        family-server = {
          enable = true;
          package = pkgs.fabricServers.fabric-1_21_1;
          jvmOpts = "-Xmx4096";
          #restart = "no";
          #enableReload = true;

          serverProperties = {
            difficulty = 3;
            gamemode = 1;
            motd = "hello friends c:";
            white-list = false;
            view-distance = 10;
            server-port = 25565; #use if adding a second server, default 25565
          };
          /*
            whitelist = {
          };
          */

          symlinks = {
            "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
              Lithium = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/5szYtenV/lithium-fabric-mc1.21.1-0.13.0.jar";
                sha256 = "0q8dj7j2z7s6y41idq665p62ni2n9k2n7n72w4307gwpwgz73lqh";
              };
              FerriteCore = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/uXXizFIs/versions/wmIZ4wP4/ferritecore-7.0.0-fabric.jar";
                sha256 = "08q3cs3z97i4z3f4idf4c3hf2dh640wksk6wbv7s7rjx3w6j0c9c";
              };
              ModernFix = pkgs.fetchurl {
                url = "https://shorturl.at/26t5C"; #uses a shorturl because the original uses an illegal character
                sha256 = "1mqx9zvnb19nz93wwa3p1i7gx05wd7whraysj555g7bcxcf69fgz";
              };
              Krypton = pkgs.fetchurl {
                url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/Acz3ttTp/krypton-0.2.8.jar";
                sha256 = "1zp394pvrdmsk380zzz8fp63cj6qrlaxmjgxxxjdmr94kf0rbwcl";
              };
            });
          };
        };
      };
    };

    environment.systemPackages = [pkgs.ngrok];
  };
}
